SELECT
    title,
    rental_rate,
    rental_duration,
    ROUND(rental_rate / rental_duration, 2) AS price_per_day
FROM
    film
ORDER BY
    price_per_day DESC
LIMIT
    10