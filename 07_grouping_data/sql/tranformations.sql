SELECT
    id AS food,
    week_id as week,
    SUBSTRING(week, 1, 4) as year,
    value as number_of_searches
FROM
    food;

CREATE TABLE IF NOT EXISTS cleaned_food AS (
    SELECT
        id AS food,
        week_id AS week,
        SUBSTRING(week, 1, 4) as year,
        value as number_of_searches
    FROM
        food
);