SELECT
    food,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food;

SELECT
    food,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food
ORDER BY
    total_searches DESC
LIMIT
    10;

SELECT
    year,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    year
ORDER BY
    year;

SELECT
    year,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    year
HAVING
    total_searches > 300000
ORDER BY
    total_searches desc;

¨
SELECT
    year,
    food,
    SUM(number_of_searches) AS total_searches
FROM
    cleaned_food
GROUP BY
    food,
    year
HAVING
    food in ('pizza', 'sushi')
ORDER BY
    food,
    year;