-- 1

SELECT
    CONCAT(
        cu.last_name,
        ", ",
        cu.first_name
    ) as full_name,
    ad.address,
    ci.city
FROM customer cu
    JOIN `address` ad USING(address_id)
    JOIN city ci USING(city_id)
    JOIN country co USING(country_id)
WHERE co.country = "Argentina";

-- 2

SELECT
    f.title,
    l.name as language,
    CASE f.rating
        WHEN "G" THEN "General Audiences"
        WHEN "PG" THEN "Parental Guidance Suggested"
        WHEN "PG-13" THEN "Parents Strongly Cautioned"
        WHEN "R" THEN "Restricted"
        WHEN "NC-17" THEN "Adults Only"
    END as rate
FROM film f
    JOIN `language` l USING(language_id);

-- 3

SELECT
    CONCAT(
        ac.last_name,
        ", ",
        ac.first_name
    ) as full_name,
    GROUP_CONCAT(
        CONCAT(
            "Title: ",
            f.title,
            ", Year: ",
            f.release_year
        )
        ORDER BY
            f.title SEPARATOR "; "
    ) as films
FROM actor ac
    JOIN film_actor USING(actor_id)
    JOIN film f USING(film_id)
GROUP BY ac.actor_id
ORDER BY ac.last_name;