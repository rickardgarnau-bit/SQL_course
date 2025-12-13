SELECT
    c.first_name || ' ' || c.last_name as full_name,
    SUM(p.amount) as total_spent
FROM
    customer c
    LEFT JOIN payment p USING (customer_id)
GROUP BY
    full_name
ORDER BY
    total_spent DESC
LIMIT
    5