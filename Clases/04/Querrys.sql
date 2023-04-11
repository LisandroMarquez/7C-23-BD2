-- QUERRYS
use sakila;

-- 1

Select f.title, f.special_features
From film f
Where f.rating="PG-13";

-- 2

Select distinct f.length
From film f
Order by f.length;

-- 3

Select f.title, f.rental_rate, f.replacement_cost
From film f
Where f.replacement_cost = 24;

-- 4

Select f.title, c.name, f.rating
From film f Join film_category fc on f.film_id = fc.film_id Join category c on fc.category_id = c.category_id
Where f.special_features = "Behind the Scenes";

-- 5

Select a.first_name, a.last_name
From actor a Join film_actor fa on a.actor_id = fa.actor_id Join film f on fa.film_id = f.film_id
Where f.title = 'ZOOLANDER FICTION';

-- 6

Select a.address, ci.city, co.country
From store s Join address a on s.address_id = a.address_id Join city ci on a.city_id = ci.city_id Join country co on ci.country_id = co.country_id
Where s.store_id = 1;

-- 7

Select f1.title, f1.rating, f2.title, f2.rating
From film f1, film f2
Where f1.rating = f2.rating and f1.film_id <> f2.film_id
Order by f1.title;

-- 8

Select f.title, concat(st.first_name, ' ', st.last_name) as full_name
From film f Join inventory i on f.film_id = i.film_id Join store s on i.store_id = s.store_id Join staff st on s.store_id = st.store_id
Where s.store_id = 2;