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

-- d) The rental rate is the cost to rent a movie and the rental duration is the number of days a customer can
-- keep the movie. The Manager wants to know the 10 most expensive movies to rent per day.
SELECT
    title,
    rental_rate,
    rental_duration,
    (rental_rate / rental_duration) AS max_date_diff
FROM
    sakila.main.film
ORDER BY
    max_date_diff DESC
LIMIT
    10;

-- e) Which actors have played in most movies? Show the top 10 actors with the number of movies they have played in.
SELECT
    a.first_name,
    a.last_name,
    COUNT(*) AS total_movies
FROM
    sakila.main.film f
    LEFT JOIN sakila.main.film_actor fa USING (film_id)
    LEFT JOIN sakila.main.actor a USING (actor_id)
GROUP BY
    a.first_name,
    a.last_name
ORDER BY
    total_movies DESC
LIMIT
    10;

-- f) Now it's time for you to choose your own question to explore the sakila database! Write down 3-5 questions you want to answer and then answer them using pandas and duckdb.
-- Which actor has appeared in the most movies within each genre?
-- Which top 5 countries have the most registered customers?
-- Which movie rating has generated the most total sales revenue?
-- Which staff member is the 'Employee of the Month' based on total processed payments?
-- On average, which movies do customers keep the longest before returning them?