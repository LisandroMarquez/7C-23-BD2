-- 1

SELECT
    CONCAT(
        cu.last_name,
        ", ",
        cu.first_name
    ) as full_name,
    ad.address,
    ci.city
FROM customer cu
    JOIN `address` ad USING(address_id)
    JOIN city ci USING(city_id)
    JOIN country co USING(country_id)
WHERE co.country = "Argentina";

-- 2

SELECT
    f.title,
    l.name as language,
    CASE f.rating
        WHEN "G" THEN "General Audiences"
        WHEN "PG" THEN "Parental Guidance Suggested"
        WHEN "PG-13" THEN "Parents Strongly Cautioned"
        WHEN "R" THEN "Restricted"
        WHEN "NC-17" THEN "Adults Only"
    END as rate
FROM film f
    JOIN `language` l USING(language_id);

-- 3

SELECT
    CONCAT(
        ac.last_name,
        ", ",
        ac.first_name
    ) as full_name,
    GROUP_CONCAT(
        CONCAT(
            "Title: ",
            f.title,
            ", Year: ",
            f.release_year
        )
        ORDER BY
            f.title SEPARATOR "; "
    ) as films
FROM actor ac
    JOIN film_actor USING(actor_id)
    JOIN film f USING(film_id)
GROUP BY ac.actor_id
ORDER BY ac.last_name;

-- 4

SELECT
    f.title as movie_rented,
    CONCAT(
        cu.last_name,
        ", ",
        cu.first_name
    ) as customer_full_name,
    CASE
        WHEN r.return_date IS NULL THEN "NO"
        ELSE "YES"
    END as returned,
    r.return_date,
    r.rental_date
FROM film f
    JOIN inventory i USING(film_id)
    JOIN rental r USING(inventory_id)
    JOIN customer cu USING(customer_id)
WHERE
    MONTH(rental_date) = '05'
    OR MONTH(rental_date) = '06';

-- 5

/*
 Las diferencias entre las funciones CONVERT() y CAST() son las siguientes:
 CAST([value] AS [data_type])
 CONVERT([value], [data_type])
 Además, el Convert() permite utilizar codificaciones de caracteres como utf-8 o utf-16 con la siguiente sentencia:
 CONVERT([value] USING [transcoding_name])
 */

-- 6

/*
 METHODS:
 - ISNULL([expression]) esta funcion devuelve un 1 si la expresion es nula o un 0 en caso contrario.
 - IFNULL([expression1], [expression2]) esta funcion devuelve la expresion 1 en caso de esta misma no ser nula, en caso contrario, devuelve la expresion 2.
 - COALESCE([value1], [value2], [value3], ...) esta funcion devuelve el primer valor que no sea nulo de la lista, en caso de ser todos nulos, devuelve NULL
 NOT SQL METHOD:
 - NVL() funciona exactamente igual que COALESCE() y es la funcion que no se encuentra dentro de MySQL
 */