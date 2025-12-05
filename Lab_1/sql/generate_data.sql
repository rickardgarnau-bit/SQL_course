/*-------------------- 
TASK 1
---------------------*/
-- a) Which movies are longer than 3 hours (180 minutes), show the title and its length?
SELECT
    title,
    length as film_length
FROM
    sakila.main.film
WHERE
    length > 180
ORDER BY
    film_length DESC;

-- b) b) Which movies have the word "love" in its title? Show the following columns: title, rating, length, description
SELECT
    title,
    rating,
    length,
    description
FROM
    sakila.main.film
WHERE
    title ILIKE '%love%';

-- c) Calculate descriptive statistics on the length column, The Manager wants, shortest, average, median and longest movie length
SELECT
    MIN(length) as min_length,
    AVG(length) as avg_length,
    MEDIAN (length) as median_length,
    MAX(length) as max_length
FROM
    sakila.main.film;