SELECT
    c.name as genre,
    SUM(amount) as total_revenue
FROM
    sakila.main.category c
    LEFT JOIN sakila.main.film_category fc USING (category_id)
    LEFT JOIN sakila.main.film f USING (film_id)
    LEFT JOIN sakila.main.inventory i USING (film_id)
    LEFT JOIN sakila.main.rental r USING (inventory_id)
    LEFT JOIN sakila.main.payment p USING (rental_id)
GROUP BY
    genre
ORDER BY
    total_revenue DESC
LIMIT
    10