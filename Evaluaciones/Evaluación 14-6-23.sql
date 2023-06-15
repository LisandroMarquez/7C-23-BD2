-- 1) Mostrar aquellas películas cuya cantidad de actores sea mayor o igual al promedio de actores por películas. Además, mostrar su cantidad de actores y una lista de los nombres de esos actores.

SELECT
    f.title,
    GROUP_CONCAT(
        ac.first_name
        ORDER BY
            ac.first_name SEPARATOR ", "
    ) as Actores,
    COUNT(ac.actor_id) as CantidadActores
FROM film f
    JOIN film_actor fa USING (film_id)
    JOIN actor ac USING (actor_id)
GROUP BY f.title
HAVING COUNT(ac.actor_id) >= (
        SELECT AVG(Cantidad)
        FROM actor a3, (
                SELECT
                    COUNT(a2.actor_id) as Cantidad
                FROM actor a2
                    JOIN film_actor fa USING (actor_id)
                    JOIN film f USING (film_id)
                GROUP BY
                    f.title
            ) as t1
    );

-- 2) Obtener los pares de pagos realizados por el mismo cliente, considerando los clientes cuyo nombre NO comienza con alguna vocal. Mostrar el nombre del cliente y los 2 montos.

SELECT
    CONCAT(
        cu.first_name,
        " ",
        cu.last_name
    ) as full_name_customer,
    pa.amount,
    pa2.amount
FROM payment pa, payment pa2
    JOIN customer cu USING(customer_id)
WHERE cu.first_name NOT IN (
        SELECT cu2.first_name
        FROM customer cu2
        WHERE
            cu2.first_name LIKE "A%"
            OR cu2.first_name LIKE "E%"
            OR cu2.first_name LIKE "I%"
            OR cu2.first_name LIKE "O%"
            OR cu2.first_name LIKE "U%"
    )
    AND pa.payment_id <> pa2.payment_id
ORDER BY cu.first_name;

-- 3) Listar todas las películas cuya duración no sea ni la máxima ni la mínima, y que no tengan a los actores cuyas IDs son (11, 56, 45, 34, 89). Además, el replacement cost no debe ser el máximo.

SELECT f.title, f.length
FROM film f
    JOIN film_actor fa USING(film_id)
    JOIN actor ac USING(actor_id)
WHERE f.length != (
        SELECT MAX(length)
        FROM
            film f2
    )
    AND f.length != (
        SELECT MIN(length)
        FROM
            film f2
    )
    AND f.replacement_cost != (
        SELECT
            MAX(replacement_cost)
        FROM
            film f2
    )
    AND ac.actor_id NOT IN (
        SELECT a2.actor_id
        FROM actor a2
        WHERE
            a2.actor_id != 11
            AND a2.actor_id != 34
            AND a2.actor_id != 45
            AND a2.actor_id != 56
            AND a2.actor_id != 89
    )
ORDER BY f.`length`;