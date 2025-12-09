SELECT 
    rating,
    COUNT(*) AS number_film
FROM sakila.main.film
GROUP BY rating