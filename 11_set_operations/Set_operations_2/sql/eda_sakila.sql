FROM
    actor;

FROM
    film;

FROM
    address;

FROM
    city;

FROM
    category;

FROM
    country;

FROM
    customer;

From
    film_actor;

SELECT
    COUNT(*) AS number_movies,
    COUNT(DISTINCT title) AS unique_number_of_titles
FROM
    film;

SELECT DISTINCT
    rating
FROM
    main.film;

DESC TABLE film_actor;

SELECT
    'customer' AS TYPE, -- 'creates a new column called TYPE'
    c.first_name, -- we're using compound queries. Combined queries
    -- are formed by using some type of operator to join the two queries.
    -- here we use the LIKE operator
    c.last_name
FROM
    customer c -- find every customer whose first name starts with D
WHERE
    c.first_name LIKE 'D%';

-- more EDAs left for the reader