-- SUBQUERRIES
use sakila;

-- Ejercicio 1

SELECT a1.first_name, a1.last_name
FROM actor a1
WHERE EXISTS    (SELECT *
                FROM actor a2
                WHERE a1.first_name = a2.first_name
                AND a1.actor_id <> a2.actor_id)
ORDER BY a1.first_name;

-- Ejercicio 2

SELECT concat(a.first_name, ' ', a.last_name) as full_name
FROM actor a
WHERE NOT EXISTS    (SELECT *
                    FROM film_actor fm
                    WHERE a.actor_id = fm.actor_id
);

-- Ejercicio 3

SELECT concat(c.first_name, ' ', c.last_name) as full_name
FROM customer c
WHERE NOT EXISTS    (SELECT *
                    FROM rental r
                    WHERE c.customer_id = r.customer_id
);

-- Ejercicio 4

SELECT concat(c.first_name, ' ', c.last_name) as full_name
FROM customer c
WHERE          (SELECT count(*)
                FROM rental r
                WHERE c.customer_id = r.customer_id
) > 1;

-- Ejercicio 5

SELECT concat(a.first_name, ' ', a.last_name) as full_name
FROM actor a
WHERE EXISTS    (SELECT *
                FROM film f JOIN film_actor fm on f.film_id = fm.film_id
                WHERE f.film_id = fm.film_id
                AND a.actor_id = fm.actor_id
                AND (f.title = 'BETRAYED REAR' or f.title = 'CATCH AMISTAD')
);

-- Ejercicio 6

SELECT concat(a.first_name, ' ', a.last_name) as full_name
FROM actor a
WHERE EXISTS    (SELECT *
                FROM film f JOIN film_actor fm on f.film_id = fm.film_id
                WHERE f.film_id = fm.film_id
                AND a.actor_id = fm.actor_id
                AND (f.title = 'BETRAYED REAR' AND NOT f.title = 'CATCH AMISTAD')
);

-- Ejercicio 7

SELECT concat(a.first_name, ' ', a.last_name) as full_name
FROM actor a
WHERE EXISTS    (SELECT *
                FROM film f JOIN film_actor fm on f.film_id = fm.film_id
                WHERE f.film_id = fm.film_id
                AND a.actor_id = fm.actor_id
                AND (f.title = 'BETRAYED REAR' AND f.title = 'CATCH AMISTAD')
);

-- Ejercicio 8

SELECT concat(a.first_name, ' ', a.last_name) as full_name
FROM actor a
WHERE NOT EXISTS    (SELECT *
                    FROM film f JOIN film_actor fm on f.film_id = fm.film_id
                    WHERE f.film_id = fm.film_id
                    AND a.actor_id = fm.actor_id
                    AND (f.title = 'BETRAYED REAR' or f.title = 'CATCH AMISTAD')
);