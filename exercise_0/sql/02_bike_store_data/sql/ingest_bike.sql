-- a) Create a database file called bike_join.duckdb and ingest the data from the csv file into your database.
CREATE TABLE
    IF NOT EXISTS bike_orders AS
SELECT
    *
FROM
    read_csv_auto ('data/bike_joined_table.csv');

-- b) The column order_id is the unique identifier of an order. How many unique orders are in the data?
SELECT
    COUNT(DISTINCT order_id)
FROM
    bike_orders;

-- c) A unique order can involve multiple products. The column product_id is the unique identifier of a product.
-- How many unique products are in the data?
SELECT
    COUNT(DISTINCT product_id)
FROM
    bike_orders;

-- d) For the product with product_name Surly Straggler - 2016, how many customers have ordered it?
-- How much is the total sales value coming from these orders?
SELECT
    COUNT(DISTINCT customer_id) AS total_customers,
    SUM(quantity * list_price) AS total_sales_value
FROM
    bike_orders
WHERE
    product_name = 'Surly Straggler - 2016';

-- e) How many customers are coming from these cities: San Angelo, Orchard Park and Merrick?
SELECT
    COUNT(DISTINCT customer_id)
FROM
    bike_orders
WHERE
    customer_city IN ('San Angelo', 'Orchard Park', 'Merrick');

-- f) Create a new column manager_name using the information below:
/* manager_id	manager_name
1	Amy Andersson
2	Bill Berg
5	Cathy Larsson
7	Davis Lam */
UPDATE bike_orders
SET
    manager_name = CASE
        WHEN manager_id = 1 THEN 'Amy Andersson'
        WHEN manager_id = 2 THEN 'Bill Berg'
        WHEN manager_id = 5 THEN 'Cathy Larsson'
        WHEN manager_id = 7 THEN 'Davis Lam'
    END;

---
SELECT
    manager_id,
    manager_name
FROM
    bike_orders
LIMIT
    10;