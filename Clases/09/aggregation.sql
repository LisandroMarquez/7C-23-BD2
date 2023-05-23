-- SUBQUERRIES
use sakila;

-- Ejercicio 1
SELECT country, count(city) as cities
FROM country
JOIN city USING(country_id)
GROUP BY country_id;

-- Ejercicio 2
SELECT country, count(city) as cities
FROM country
JOIN city USING(country_id)
GROUP BY country_id
HAVING count(country_id) > 10
ORDER BY count(city) DESC;

-- Ejercicio 3
SELECT concat(c.first_name, ' ', c.last_name) as full_name, a.address, COUNT(r.rental_id) AS total_films_rented, SUM(p.amount) AS total_money_spent
FROM customer c
JOIN address a USING(address_id)
JOIN rental r USING(customer_id)
JOIN payment p USING(customer_id)
GROUP BY c.customer_id
ORDER BY SUM(p.amount) DESC;

-- Ejercicio 4
SELECT c.name AS category, AVG(f.length) AS average_duration
FROM film f
JOIN film_category fc USING(film_id)
JOIN category c USING(category_id)
GROUP BY c.category_id
ORDER BY AVG(f.length) DESC;

-- Ejercicio 5
SELECT f.rating, SUM(r.rental_id) AS total_rentals, SUM(p.amount) AS total_sales -- No sabía si se refería al total de rentas o el total de monto de ventas así que puse ambos por las dudas
FROM film f
JOIN inventory i USING(film_id)
JOIN rental r USING(inventory_id)
JOIN payment p USING(rental_id)
GROUP BY f.rating;