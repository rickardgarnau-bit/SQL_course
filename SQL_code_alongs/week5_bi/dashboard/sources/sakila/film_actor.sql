SELECT
    a.first_name || a.last_name AS actor,
    f.title AS film,
    f.rating
FROM
    sakila.main.actor a
    LEFT JOIN sakila.main.film_actor fa ON a.actor_id = fa.actor_id
    LEFT JOIN sakila.main.film f ON f.film_id = fa.film_id;