SELECT
    f.title,
    AVG(
        EXTRACT( -- LLM användes eftersom det inte gick att använda AVG(return_date - rental_date) för att får grafen. 
            --EXTRACT(DAY FROM ...) - detta konverterar INTERVAL till antal dagar som ett nummer.
            DAY
            FROM
                (r.return_date - r.rental_date)
        )
    ) as avg_rental_days
FROM
    sakila.main.film f
    LEFT JOIN sakila.main.inventory i USING (film_id)
    LEFT JOIN sakila.main.rental r USING (inventory_id)
WHERE
    r.return_date IS NOT NULL
GROUP BY
    f.title
ORDER BY
    avg_rental_days DESC
LIMIT
    10