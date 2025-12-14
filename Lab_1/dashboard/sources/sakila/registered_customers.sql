SELECT
    country.country,
    COUNT(DISTINCT c.customer_id) as total_customers
FROM
    customer c
    LEFT JOIN address a ON c.address_id = a.address_id
    LEFT JOIN city ci ON a.city_id = ci.city_id
    LEFT JOIN country ON ci.country_id = country.country_id
GROUP BY
    country.country
ORDER BY
    total_customers DESC
LIMIT
    10