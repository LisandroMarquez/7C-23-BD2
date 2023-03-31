-- All & Any Querries
-- (1)
Select title, rating
From film
Where length <= All     (Select length
                        From film);

-- (2)
Select title
From film f1
Where length <= All     (Select length
                        From film f2)
Having count(*) = 1;

-- (3)
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, p.amount
From customer c
Join payment p on c.id = p.customer_id
Join address a on c.address_id = a.id
Where p.amount <= All   (Select p2.amount
                        From payment p2);

-- (4)
-- PREGUNTAR COMO DEVOLVER ESTO EN LA MISMA FILA !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, p.amount
From customer c
Join payment p on c.id = p.customer_id
Join address a on c.address_id = a.id
Where p.amount <= All   (Select p2.amount
                        From payment p2)
or p.amount >= All   (Select p2.amount
                        From payment p2)
Order by p.amount;