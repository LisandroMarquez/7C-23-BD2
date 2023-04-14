-- All & Any Querries
use sakila;

-- (1)
Select title, rating, length as min_length
From film f1
Where length <= All (Select length
                    From film f2);

-- (2)
Select title
From film
Where length <= ALL
    (Select length
    From film)
Having count(*) = 1;

-- (3)
-- ALL Querry
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, p.amount
From customer c
Join payment p on c.customer_id = p.customer_id
Join address a on c.address_id = a.address_id
Where p.amount <= All   (Select p2.amount
                        From payment p2)
Order by c.first_name;

-- ANY and MIN Querry
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, p.amount
From customer c
Join payment p on c.customer_id = p.customer_id
Join address a on c.address_id = a.address_id
Where p.amount = Any    (Select MIN(p2.amount)
                        From payment p2)
Order by c.first_name;

-- (4)
Select c.first_name, c.last_name, a.address, MAX(p.amount) as highest_payment, MIN(p.amount) as lowest_payment 
From customer c
Join address a on c.address_id = a.address_id 
Join payment p on c.customer_id = p.customer_id 
Group by c.customer_id 
Having count(Distinct p.amount) > 1;