-- JOIN SENTENCE

use sakila;

-- Ejercicio 4

SELECT film_id, title
FROM film
WHERE film_id NOT IN (
        SELECT film_id
        FROM inventory
    );

-- Ejercicio 5

SELECT f.title, i.inventory_id
FROM film f
    INNER JOIN inventory i USING(film_id)
    LEFT JOIN rental r USING(inventory_id)
WHERE r.inventory_id IS NULL
GROUP BY (f.title);

-- Ejercicio 6

SELECT
    CONCAT(c.last_name, " ", c.first_name) AS full_name,
    i.store_id,
    f.title,
    r.rental_date,
    r.return_date
FROM customer c
    JOIN rental r USING(customer_id)
    JOIN inventory i USING(inventory_id)
    JOIN film f USING(film_id)
ORDER BY
    i.store_id,
    c.last_name;

-- Ejercicio 7

SELECT
    CONCAT(ci.city, ', ', co.country) AS location,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    SUM(pa.amount) AS total_sales
FROM store st
    JOIN address ad ON st.address_id = ad.address_id
    JOIN city ci ON ad.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    JOIN staff s ON st.manager_staff_id = s.staff_id
    JOIN customer cu ON st.store_id = cu.store_id
    JOIN rental r ON cu.customer_id = r.customer_id
    JOIN payment pa ON r.rental_id = pa.rental_id
GROUP BY
    st.store_id,
    location,
    staff_name
ORDER BY st.store_id;

-- Ejercicio 8

SELECT
    CONCAT(a.last_name, " ", a.first_name) as actor_name,
    COUNT(fa.film_id) AS film_counter
FROM actor a
    JOIN film_actor fa USING(actor_id)
GROUP BY a.last_name
ORDER BY film_counter DESC
LIMIT 1;