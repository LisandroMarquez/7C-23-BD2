# DB Creation drop database if exists triggerSql;

create DATABASE triggerSql;

use triggerSql;

CREATE TABLE
    `employees` (
        `employeeNumber` int(11) NOT NULL,
        `lastName` varchar(50) NOT NULL,
        `firstName` varchar(50) NOT NULL,
        `extension` varchar(10) NOT NULL,
        `email` varchar(100) NOT NULL,
        `officeCode` varchar(10) NOT NULL,
        `reportsTo` int(11) DEFAULT NULL,
        `jobTitle` varchar(50) NOT NULL,
        PRIMARY KEY (`employeeNumber`)
    );

INSERT INTO
    employees (
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officeCode,
        reportsTo,
        jobTitle
    )
VALUES (
        1002,
        'Murphy',
        'Diane',
        'x5800',
        'dmurphy@classicmodelcars.com',
        '1',
        NULL,
        'President'
    ), (
        1056,
        'Patterson',
        'Mary',
        'x4611',
        'mpatterso@classicmodelcars.com',
        '1',
        1002,
        'VP Sales'
    ), (
        1076,
        'Firrelli',
        'Jeff',
        'x9273',
        'jfirrelli@classicmodelcars.com',
        '1',
        1002,
        'VP Marketing'
    );

# 1
INSERT INTO
    employees (
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officeCode,
        reportsTo,
        jobTitle
    )
VALUES (
        19,
        'Marquez',
        'Lisandro',
        'x6000',
        NULL,
        '1',
        1002,
        'VP Marketing'
    );

/*
 Error: Column "email" cannot be null
 El campo email en la definición de la tabla dice estrictamente que ese campo no puede ser nulo: "`email` varchar(100) NOT NULL"
 */

INSERT INTO
    employees (
        employeeNumber,
        lastName,
        firstName,
        extension,
        email,
        officeCode,
        reportsTo,
        jobTitle
    )
VALUES (
        19,
        'Marquez',
        'Lisandro',
        'x6000',
        "lichimarquez04@gmail.com",
        '1',
        1002,
        'VP Marketing'
    );

-- Ahora que mail dejó de ser nulo, nos dejara insertar los datos

# 2 

UPDATE employees SET employeeNumber = employeeNumber - 20;

/*
 Se les resta 20 al número de cada empleado, como ninguno se va a superponer debido a que todos son modificados bajo el mismo criterio; no ocurre ningún error. Incluso, el campo "int" permite guardar números negativos.
 */

# 3 

ALTER TABLE employees
ADD
    COLUMN age INT CHECK (
        age >= 16
        AND age <= 70
    );

# 4 

/*
 La tabla "film_actor" desempeña el papel de intermediaria entre las tablas "film" y "actor", posibilitando el funcionamiento de la relación de muchos a muchos que existe entre ambas tablas. Permitiendo que un actor puede participar en múltiples películas, en contraste con el hecho de que una película puede involucrar a varios actores. Dentro de la tabla "film_actor", el campo "film_id" establece una conexión entre la película y el campo "actor_id", lo cual indica qué actor participó en determinada película. Este proceso se repite para todos los registros presentes en la tabla "film_actor".
 */

# 5 

ALTER TABLE employees
ADD
    COLUMN lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ADD
    COLUMN lastUpdateUser VARCHAR(50);

/*
 Creamos la columna y le asignamos que se actualice con cada actualización a la fecha en la que ocurra dicho suceso
 */

CREATE TRIGGER EMPLOYEE_INSERT_TRIGGER BEFORE INSERT 
ON EMPLOYEES FOR EACH ROW BEGIN SET 
	SET NEW.lastUpdate = CURRENT_TIMESTAMP;
	END;


/*
 Esto es para los inserts de nuevos empleados
 */

CREATE TRIGGER EMPLOYEE_UPDATE_TRIGGER BEFORE UPDATE 
ON EMPLOYEES FOR EACH ROW BEGIN SET 
	SET NEW.lastUpdate = CURRENT_TIMESTAMP;
	END;


/*
 Esto es para los updates de empleados existentes
 */

Show TRIGGERS;

# Para mostrar los triggers creados y su funcionamiento 

# 6 

use sakila;

Show TRIGGERS;

/*
 Mostramos todos los códigos de la "db sakila"
 Los triggers relacionados con film_text son:
 - ins_film
 - upd_film
 - del_film
 */

BEGIN
INSERT INTO
    film_text (film_id, title, description)
VALUES (
        new.film_id,
        new.title,
        new.description
    );

END # Ins_film realiza la copia automática de los valores de film_id, title y description desde una fila recién insertada hacia otra tabla denominada film_text. Esta función garantiza la sincronización constante de datos entre ambas tablas de manera efectiva.

BEGIN IF (old.title != new.title)
OR (
    old.description != new.description
)
OR (old.film_id != new.film_id) THEN
UPDATE film_text
SET
    title = new.title,
    description = new.description,
    film_id = new.film_id
WHERE film_id = old.film_id;

END IF;

END # Automáticamente, se lleva a cabo la actualización de los valores dentro de la tabla film_text en el instante en que una fila es modificada en otra tabla. Este proceso garantiza la perfecta sincronización de datos entre ambas tablas, permitiendo que los cambios efectuados en la fila original se reflejen de manera precisa en la tabla film_text.

BEGIN DELETE FROM film_text WHERE film_id = old.film_id;

END # Borra automáticamente ciertas filas de la tabla film_text cuando se elimina dicha fila en la otra tabla.