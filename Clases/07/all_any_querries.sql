-- All & Any Querries
use sakila;

-- (1)
SELECT title, rating, length as min_length
FROM film f1
WHERE length <= All (SELECT length
                    FROM film f2);

-- (2)
SELECT title
FROM film
WHERE length <= ALL
    (SELECT length
    FROM film)
HAVING COUNT(*) = 1;

-- (3)
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, p.amount
From customer c
Join payment p on c.customer_id = p.customer_id
Join address a on c.address_id = a.address_id
Where p.amount <= All   (Select p2.amount
                        From payment p2)
Order by c.first_name;

-- (4)
-- Mostrar misma fila, no columna :/
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, MIN(p.amount) as amount
From customer c
Join payment p on c.customer_id = p.customer_id
Join address a on c.address_id = a.address_id
Where p.amount <= All   (Select p2.amount
                        From payment p2)
UNION
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, MAX(p.amount) as amount
From customer c
Join payment p on c.customer_id = p.customer_id
Join address a on c.address_id = a.address_id
Where p.amount >= All   (Select p2.amount
                        From payment p2);