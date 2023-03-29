-- QUERRYS

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
From film f Join film_category fc on f.id = fc.film_id Join category c on fc.category_id = c.id
Where f.special_features = "Behing the Scenes";

-- 5

Select a.first_name, a.last_name
From actor a Join film_actor fa on a.id = fa.actor_id Join film f on fa.film_id = f.id
Where f.title = 'ZOOLANDER FICTION';

-- 6

Select a.address, ci.city, co.country
From store s Join address a on s.address_id = a.id Join city ci on a.city_id = ci.id Join country co on ci.country_id = co.id
Where s.id = 1;

-- 7

Select f.title, f.rating
From film f
Group by f.rating
Order by f.rating, f.title;

-- 8

Select f.title, concat(st.first_name, ' ', st.last_name) as full_name
From film f Join inventory i on f.id = i.film_id Join store s on i.store_id = s.id Join staff st on s.id = st.store_id
Where s.id = 2;