SELECT
    MIN(salary_in_usd) AS min_salary_usd,
    AVG(salary_in_usd) AS avg_salary_usd,
    MEDIAN(salary_in_usd) AS median_salary_usd,
    MAX(salary_in_usd) AS max_salary_usd,
FROM
    data_jobs;