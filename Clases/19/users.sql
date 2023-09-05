# 1) 

CREATE USER "data_analyst" IDENTIFIED BY "pepe1234";

# 2) 

SHOW GRANTS FOR "data_analyst"@"%";

GRANT SELECT, UPDATE, DELETE ON sakila.* TO "data_analyst"@"%";

# 3) 

show databases;

/* Ingresé con el usuario y comprobé que solo pudiera ver la db sakila
 +--------------------+
 | Database           |
 +--------------------+
 | information_schema |
 | sakila             |
 +--------------------+
 */

USE sakila;

CREATE TABLE
    something(
        `id` INT(11) PRIMARY KEY AUTO_INCREMENT,
        `field` VARCHAR(50)
    );

/*
 El error que tira es el siguiente:
 ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 'something'
 Ocurre porque no le hemos brindado el permiso de crear tablas
 */

# 4) 

SELECT * FROM film WHERE film_id = 500;

UPDATE film SET original_language_id = 2 WHERE film_id = 500;

SELECT * FROM film WHERE film_id = 500;

-- A diferencia de antes, esta acción si fue peremitida al garantizarle permisos al user, por eso si podemos Updatear

# 5) 

SHOW GRANTS FOR "data_analyst"@"%";

REVOKE UPDATE ON sakila.* FROM data_analyst;

SHOW GRANTS FOR "data_analyst"@"%";

# 6) 

USE sakila;

SELECT * FROM film WHERE film_id = 500;

UPDATE film SET original_language_id = NULL WHERE film_id = 500;

/*
 El error que tira es el siguiente:
 ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
 Ocurre porque no le hemos removido el permido de updatear tablas
 */