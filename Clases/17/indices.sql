# 1)
# Querry 1
SELECT ad.postal_code
FROM `address` ad
WHERE ad.postal_code IN(
        SELECT a2.address_id
        FROM `address` a2
            INNER JOIN staff s USING(address_id)
        WHERE
            s.picture NOT NULL
    )
ORDER BY postal_code;

# Querry 2
SELECT
    ad.postal_code,
    ci.city,
    co.country
FROM `address` ad
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id)
WHERE ad.city_id < 300
ORDER BY postal_code;

# Querry 3 

CREATE INDEX postalCode on address(postal_code);

-- MySQL verifica si los índices existen y luego usa los índices para seleccionar las filas físicas exactas correspondientes de la tabla en lugar de escanear toda la tabla. Por eso demora menos que antes.

# 2 

SELECT first_name FROM actor WHERE first_name LIKE "A%";

SELECT last_name FROM actor WHERE last_name LIKE "%R";

-- La diferencia es que los apellidos están ordenados alfabéticamente y los nombres no. Esto ocurre ya que la columna "last_name" tiene un index que los ordena.

# 3
SELECT `description`
FROM film
WHERE
    `description` LIKE "%YARN%"
ORDER BY `description`;

SELECT `description`
FROM film_text
WHERE
    MATCH(`description`) AGAINST("YARN")
ORDER BY `description`;

-- La verdad yo no encontré nada raro ni de diferente en ambas querries. Sus tiempos de respuesta no fueron muy diferentes entre sí