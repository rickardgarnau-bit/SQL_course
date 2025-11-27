-- selects all customers and all actors with first name starting with a
SELECT
    'customer' AS TYPE,
    c.first_name,
    c.last_name
FROM
    customer c
WHERE
    c.first_name LIKE 'A%' -- we get the 'result_set a' which returns
    -- all the first names starting with A
UNION
-- then we get 'result_set b' from UNION witch returns the Actors
SELECT
    'actor',
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'A%';

-- find overlapping names between actors and customers
SELECT
    a.first_name,
    a - last_name
FROM
    actor a
INTERSECT
SELECT
    c.first_name,
    c.last_name
FROM
    customer c;

-- find all with initials JD and record its type actor, customer
SELECT
    'actor' AS "type",
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.first_name LIKE 'J%'
    And a.last_name LIKE 'D%'
UNION ALL -- UNION ALL includes all duplicates
SELECT
    'customer' AS "type",
    c.first_name,
    c.last_name
FROM
    customer c
WHERE
    c.first_name LIKE 'J%'
    And c.last_name LIKE 'D%';