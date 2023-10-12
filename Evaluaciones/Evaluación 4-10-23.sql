/*
Desarrolla un trigger que se active al insertar un nuevo registro en la tabla "Order Details". Este trigger debe realizar las siguientes verificaciones y acciones:

Verificar si la orden a la que se desea relacionar el nuevo detalle existe en la tabla "Orders". Si la orden no existe, el trigger debe generar un error con el mensaje "No existe la orden a relacionar".

Asignar automáticamente el precio al nuevo detalle de acuerdo con el precio del producto relacionado. El precio del producto se encuentra en la tabla "Products".

Verificar si hay suficiente stock del producto para satisfacer la cantidad especificada en el nuevo detalle. Si no hay suficiente stock, el trigger debe generar un error con el mensaje "No hay stock suficiente".

Si todas las verificaciones son exitosas, el trigger debe restar la cantidad comprada del stock del producto en la tabla "Products". Luego, permitirá la inserción del nuevo detalle en la tabla "Order Details".
*/

DELIMITER $$

CREATE TRIGGER OrderDetails_InsertTrigger BEFORE INSERT
ON orderdetails FOR EACH ROW
BEGIN
    INSERT INTO orderdetails
    SET action = "insert";
    IF(
    -- Controlar la orden
   EXISTS (SELECT new.OrderID FROM orderdetails),
    -- Existe
        (OrderID = new.OrderID,
        ProductID = new.ProductID,
        UnitPrice = (SELECT UnitPrice FROM products WHERE ProductID = new.ProductID),
        IF(
        -- Controlar que hay suficiente stock
        new.Quantity <= (SELECT UnitsInStock FROM products WHERE ProductID = new.ProductID),
        -- Si hay stock
        Quantity = new.Quantity,
        -- Stock insuficiente
        MESSAGE_TEXT = "No hay stock suficiente"),
        Discount = new.Discount),
    -- No existe
    MESSAGE_TEXT = "No existe la orden a relacionar"
    )
    THEN
    UPDATE products
        SET Quantity = Quantity - new.Quantity
        WHERE ProductID = new.ProductID;
END
$$

DELIMITER ;

/*
Crea una vista para un informe que considerando todas las órdenes del año actual, partiendo desde la orden más reciente (un año a partir de la fecha más reciente entre todas las órdenes).
*/
CREATE OR REPLACE VIEW informeUltimoAnio AS
SELECT
    Year(o.`OrderDate`) AS Anioo,
    p.ProductName,
    SUM(od.Quantity) AS UnidadesV
FROM orders as o
    JOIN orderdetails od USING(orderid)
    JOIN products p USING(productid)
WHERE YEAR(o.`OrderDate`) > ((SELECT YEAR(MAX(`OrderDate`)) FROM orders)-1)
GROUP BY (o.`OrderDate`), p.`ProductName`
ORDER BY o.`OrderDate`;

CREATE OR REPLACE VIEW informe2 AS
SELECT
    cu.`ContactName`,
    ca.`CategoryName`,
    COUNT(p.`ProductID`) as cantidad_productos,
    SUM((p.`UnitPrice` * od.`Quantity`)*(1-od.`Discount`/100)) AS total_recaudado,
    MIN(o.`OrderDate`) as firstOrder,
    MAX(o.`OrderDate`) as lastOrder
FROM customers cu
    JOIN orders o USING(`CustomerID`)
    JOIN orderdetails od USING(`OrderID`)
    JOIN products p USING(`ProductID`)
    JOIN categories ca USING(`CategoryID`)
GROUP BY cu.`CustomerID`, ca.`CategoryName`
HAVING total_recaudado > 4000;

/*
Se desea crear un procedimiento almacenado para actualizar los costos. El usuario proporcionará un rango de números de pedido (mínimo y máximo), y un porcentaje de aumento. El sistema buscará los productos cuya cantidad de pedidos esté dentro de esos límites. Luego, se modificará el precio actual de los productos obtenidos aplicando el multiplicador ingresado. El procedimiento mostrará el nombre del producto, el aumento, la cantidad de pedidos, el precio antes del cambio y el precio actualizado.
*/

DELIMITER $$
CREATE PROCEDURE actualizarCostos(IN minimum INT, IN maximum INT, IN perce FLOAT)
COMMENT 'Permite actualizar los costos de los productos según la cantidad de veces que aparecen en OrderDetails y el porcentaje a aumentar (minimo, maximo, porcentaje)'
proc: BEGIN
    DECLARE vProducto VARCHAR(100);
    DECLARE vCantidad INT DEFAULT 0;
    DECLARE vOldPrice INT DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
    DECLARE cur CURSOR FOR
        SELECT p.`ProductName`, COUNT(od.`ProductID`) as veces, p.`UnitPrice`
        FROM Products p
        JOIN orderdetails od USING(`ProductID`)
        GROUP BY `ProductID`
        HAVING veces BETWEEN minimum AND maximum;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done=TRUE;

    IF perce = 0 THEN
        SELECT 'Percentage parameter must be > 0';
        LEAVE proc;
    END IF;

    DROP TABLE IF EXISTS devolver;

    CREATE TEMPORARY TABLE devolver(
            nombre VARCHAR(100),
            aumento FLOAT,
            cantidad INT,
            precioViejo FLOAT,
            precioNuevo FLOAT);

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO vProducto,vCantidad,vOldPrice;

        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE Products
            SET
                `UnitPrice`= (`UnitPrice`+(`UnitPrice`*perce));

        INSERT INTO devolver
        VALUES(
            vProducto,
            perce,
            vCantidad,
            vOldPrice,
            (SELECT `UnitPrice` FROM products WHERE `ProductName`=vProducto)
        );
    END LOOP;
    CLOSE cur;

    SELECT * FROM devolver;

    DROP TABLE devolver;
END

DELIMITER ;

CALL actualizarCostos(6,6,0);