/*=============
 Query teh data
 ===============*/
-- overview of data
DESC;

DESC staging.joined_tables;

-- select all or some columns
SELECT
    *
FROM
    staging.joined_tables;

SELECT
    order_date,
    customer_first_name,
    customer_last_name,
    product_name
FROM
    staging.joined_tables;

-- filter rows eith WHERE clause
SELECT
    order_date,
    customer_first_name,
    customer_last_name,
    product_name
FROM
    staging.joined_tables
WHERE
    customer_first_name = 'Marvin';

-- create a new table for order status description
-- inside () what we want in the table
CREATE TABLE IF NOT EXISTS staging.status(
    order_status INTEGER,
    order_status_description VARCHAR
);

SELECT
    *
FROM
    staging.status;

INSERT INTO
    staging.status
VALUES
    (1, 'Pending'),
    (2, 'Processing'),
    (3, 'Rejected'),
    (4, 'Completed');

-- sort the rows by order_status
-- ORDER BY ... ASC/DESC
/* EXAMPLE
 SELECT 
 j.order_id,
 j.order_status,
 s.order_status_description
 FROM staging.joined_tables j --alias 'j'
 -- join status description to this table
 JOIN staging.status s ON j.order_status = s.order_status
 --ORDER BY j.order_status ASC;
 ORDER BY j.order_status DESC; 
 */