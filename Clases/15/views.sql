# JOIN SENTENCE use sakila;

# 1)
CREATE
OR
REPLACE
    VIEW list_of_customer AS
SELECT
    cu.customer_id,
    CONCAT(
        cu.first_name,
        ' ',
        cu.last_name
    ) AS full_name,
    a.`address`,
    a.postal_code AS zip_code,
    a.phone,
    city.city,
    country.country,
    if(cu.active, 'active', '') AS `status`,
    cu.store_id
FROM customer cu
    JOIN `address` a USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id);

SELECT * FROM list_of_customer;

# 2)
CREATE
OR
REPLACE VIEW film_details AS
SELECT
    f.film_id,
    f.title,
    f.description,
    ca.name AS category,
    f.rental_rate AS price,
    f.length,
    f.rating,
    group_concat(
        concat(
            ac.first_name,
            ' ',
            ac.last_name
        )
        ORDER BY
            ac.first_name SEPARATOR ', '
    ) as actors
FROM film f
    JOIN film_category USING(film_id)
    JOIN category ca USING(category_id)
    JOIN film_actor USING(film_id)
    JOIN actor ac USING(actor_id)
GROUP BY f.film_id, ca.name;

SELECT * FROM film_details;

# 3)
CREATE
OR
REPLACE
    VIEW sales_by_film_category AS
SELECT
    ca.name AS category,
    sum(pa.amount) AS total_sales
from payment pa
    JOIN rental USING(rental_id)
    JOIN inventory USING(inventory_id)
    JOIN film USING(film_id)
    JOIN film_category USING(film_id)
    JOIN category ca USING(category_id)
GROUP BY ca.`name`
ORDER BY total_sales;

SELECT * FROM sales_by_film_category;

# 4. Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.
CREATE
OR
REPLACE
    VIEW actor_information AS
SELECT
    ac.actor_id as actor_id,
    ac.first_name as first_name,
    ac.last_name as last_name,
    COUNT(film_id) as films
FROM actor ac
    JOIN film_actor USING(actor_id)
GROUP BY
    ac.actor_id,
    ac.first_name,
    ac.last_name;

SELECT * FROM actor_information;

# 5)
/*
 Lo que la query en sí hace es devolver:
 a) La ID de cada actor/actriz
 b) El nombre de cada actor/actriz
 c) El apellido de cada actor/actriz
 d) Una lista con todas las películas en las que actua ordenadas de la siguiente manera:
 Categoría1: PELÍCULA1, Categoría2: PELÍCULA2, PELÍCULA3, Categoría3: PELÍCULA4, PELÍCULA5, PELÍCULA6
 Ordenando alfabeticamente las categorías y dentro de cada una, organizando alfabeticamente las películas.
 Ejemplo:
 +----+------------+-----------+-------------+
 | ID | first_name | last_name |  film_info  |
 +----+------------+-----------+-------------+
 | 01 |  Lisandro  |  Marquez  | Action: JUMANJI, Horror: ABRACADABRA, SLENDERMAN, THE RING, Sci-Fi: Interstellar, Star Wars: Clone Wars |
 +----+------------+-----------+-------------+
 */
;

# 6. Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.
/*
 ASD
 */