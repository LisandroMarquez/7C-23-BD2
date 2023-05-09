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
Select CONCAT(c.first_name, ' ', c.last_name) as full_name, a.address, MIN(p.amount) as min_payment
From customer c
Join payment p on c.customer_id = p.customer_id
Join address a on c.address_id = a.address_id
Group by c.first_name
Order by c.first_name;

-- (4)
Select c.first_name, c.last_name, a.address, MAX(p.amount) as highest_payment, MIN(p.amount) as lowest_payment 
From customer c
Join address a on c.address_id = a.address_id 
Join payment p on c.customer_id = p.customer_id 
Group by c.customer_id 
Having count(Distinct p.amount) > 1;