SELECT
    strftime (payment_date, '%Y-%m') as sales_month,
    SUM(amount) as total_sales
FROM
    sakila.payment
GROUP BY
    sales_month
ORDER BY
    sales_month