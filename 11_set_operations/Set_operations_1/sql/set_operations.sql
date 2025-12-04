-- With union we get both result_set a and b. In the result we get
-- product_name 'Monitor' twice but that's because the dates are different.
-- They are not on the same rows
SELECT
    *
FROM
    synthetic.sales_jan
UNION
SELECT
    *
FROM
    synthetic.sales_feb;

-- Now 'Monitor' only appears once because duplicates in
-- Set operations gets removed by default.
-- However if we use UNION ALL the duplicates stay
SELECT
    product_name,
    amount
FROM
    synthetic.sales_jan
UNION ALL
SELECT
    product_name,
    amount
FROM
    synthetic.sales_feb;

-- Nothing gets returned because they don't have anything in common.
SELECT
    *
FROM
    synthetic.sales_jan
INTERSECT
SELECT
    *
FROM
    synthetic.sales_feb;

-- Here we get product_name and amount displayed beacuse both
-- were duplicates. They exist in both result sets.
SELECT
    product_name,
    amount
FROM
    synthetic.sales_jan
INTERSECT
SELECT
    product_name,
    amount
FROM
    synthetic.sales_feb;

-- We take everything from result_set A and remove everything
-- that also exists in result_set B which was the 'Monitor'
SELECT
    product_name,
    amount
FROM
    synthetic.sales_jan
EXCEPT
SELECT
    product_name,
    amount
FROM
    synthetic.sales_feb;