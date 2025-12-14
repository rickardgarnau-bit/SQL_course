SELECT
    'Shortest' as category,
    MIN(length) as minutes
FROM
    film
UNION ALL
SELECT
    'Average',
    AVG(length)
FROM
    film
UNION ALL
SELECT
    'Longest',
    MAX(length)
FROM
    film