/*
 1) Add a new customer
 - To store 1
 - For address use an existing address. The one that has the biggest address_id in 'United States'
 */

INSERT INTO
    customer(
        store_id,
        first_name,
        last_name,
        email,
        address_id,
        create_date
    )
VALUES (
        1,
        "Juan",
        "Perez",
        "juanperez@gmail.com", (
            SELECT
                MAX(address_id)
            from
                `address`
        ),
        NOW()
    );

/* 
 2) Add a rental
 - Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
 - Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
 - Select any staff_id from Store 2
 */

INSERT INTO
    rental(
        rental_date,
        inventory_id,
        customer_id,
        staff_id
    )
VALUES (
        NOW(), (
            SELECT film_id
            FROM film
            WHERE
                title = "CREEPERS KANE"
        ),
        600,
        2
    );

/*
 3) Update film year based on the rating
 - For example if rating is 'G' release date will be '2001'
 - You can choose the mapping between rating and year.
 - Write as many statements are needed
 */

UPDATE film SET release_year = 2000 WHERE rating = "G";

UPDATE film SET release_year = 2005 WHERE rating = "PG";

UPDATE film SET release_year = 2010 WHERE rating = "PG-13";

UPDATE film SET release_year = 2015 WHERE rating = "R";

UPDATE film SET release_year = 2020 WHERE rating = "NC-17";

/*
 5) Try to delete a film
 - Check what happens, describe what to do.
 - Write all the necessary delete statements to entirely remove the film from the DB
 */

DELETE FROM film WHERE film_id = 1000;

-- Error: Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`film_actor`, CONSTRAINT `fk_film_actor_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE)

-- Esto quiere decir que no podemos borrar la tabla debido a que esta entidad está relacionada con otras entidads de otras tablas como film_actor, film_category y inventory, y como no está permitido el DELETE ON CASCADE que elimina todas las entidades relacionadas con la entidad a eliminar; debemos hacerlo a mano.

DELETE from film_actor WHERE film_id = 1000;

DELETE from film_category WHERE film_id = 1000;

DELETE from rental
WHERE inventory_id IN (
        SELECT inventory_id
        FROM inventory
        WHERE film_id = 1000
    );

DELETE from inventory WHERE film_id = 1000;

DELETE FROM film WHERE film_id = 1000;

-- Lo que hicimos aquí arriba es eliminar todas las relaciones de la film con film_id = 1000 para poder eliminarla completamente de la DB.