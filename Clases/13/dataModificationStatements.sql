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
 4) Return a film
 - Write the necessary statements and queries for the following steps.
 - Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
 - Use the id to return the film
 */

SELECT * FROM rental WHERE return_date IS NULL;

-- Hay 184 films que no se les ha establecido return_date, a través de la inventory_id podremos obtener la film_id

SELECT *
FROM inventory
WHERE inventory_id IN (
        SELECT inventory_id
        FROM rental
        WHERE
            return_date = CURRENT_DATE()
    );

-- Así obtenemos todas las film_id que no han sido devueltas

UPDATE rental
SET return_date = NOW()
WHERE inventory_id IN (
        SELECT inventory_id
        FROM inventory
        WHERE film_id = 445
    );

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

/*
 6) Rent a film
 - Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
 - Add a rental entry
 - Add a payment entry
 - Use sub-queries for everything, except for the inventory id that can be used directly in the queries.
 */

SELECT * FROM inventory;

SELECT inventory_id FROM rental WHERE return_date IS NULL;

SELECT * FROM inventory WHERE inventory_id = 14;

INSERT INTO
    rental(
        rental_date,
        inventory_id,
        customer_id,
        staff_id
    )
VALUES(
        NOW(), 14, (
            SELECT
                customer_id
            FROM customer
            WHERE
                address_id IN (
                    SELECT (MAX(address_id) -1)
                    from
                        `address`
                )
        ), (
            SELECT
                MAX(staff_id)
            FROM staff
        )
    );

INSERT INTO
    payment(
        customer_id,
        staff_id,
        rental_id,
        amount,
        payment_date
    )
VALUES( (
            SELECT
                customer_id
            FROM customer
            WHERE
                address_id IN (
                    SELECT (MAX(address_id) -1)
                    from
                        `address`
                )
        ), (
            SELECT staff_id
            FROM staff
            WHERE
                picture IS NOT NULL
        ), (
            SELECT rental_id
            FROM rental
            WHERE
                customer_id IN (
                    SELECT
                        customer_id
                    FROM
                        customer
                    WHERE
                        address_id IN(
                            SELECT (MAX(address_id) -1)
                            FROM
                                `address`
                        )
                        AND return_date IS NULL
                )
        ),
        3.49,
        NOW()
    );