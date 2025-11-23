-- a) 
SELECT
    COUNT(*)
FROM
    cleaned_salaries
WHERE
    job_title = 'Data Engineer';

-- b)
SELECT
    COUNT(DISTINCT job_title)
FROM
    cleaned_salaries;

-- c) 
SELECT
    salary_level,
    COUNT(*)
FROM
    cleaned_salaries
GROUP BY
    salary_level;

-- d)
SELECT
    experience_level,
    AVG(salary_monthly_sek) AS mean_salary,
    MEDIAN(salary_monthly_sek) AS median_salary
FROM
    cleaned_salaries
GROUP BY
    experience_level;

-- e)
SELECT
    job_title,
    MEDIAN(salary_monthly_sek) AS median_salary
FROM
    cleaned_salaries
GROUP BY
    job_title
ORDER BY
    median_salary DESC
LIMIT
    10;

-- f)
SELECT
    remote_ratio,
    COUNT(*) AS count,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT
                COUNT(*)
            FROM
                cleaned_salaries
        ),
        1
    ) AS percentage
FROM
    cleaned_salaries
GROUP BY
    remote_ratio;

-- g)
SELECT
    company_size,
    COUNT(*) AS number_of_jobs,
    ROUND(AVG(salary_monthly_sek), 0) AS mean_salary,
    MEDIAN(salary_monthly_sek) AS median_salary
FROM
    cleaned_salaries
WHERE
    job_title = 'Data Engineer'
GROUP BY
    company_size
ORDER BY
    mean_salary DESC;

-- h)
SELECT
    experience_level,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_monthly_sek), 0) AS avg_salary,
    MEDIAN(salary_monthly_sek) AS median_salary
FROM
    cleaned_salaries
GROUP BY
    experience_level
ORDER BY
    median_salary DESC;

--
SELECT
    remote_ratio,
    COUNT(*) AS count,
    MEDIAN(salary_monthly_sek) AS median_salary
FROM
    cleaned_salaries
GROUP BY
    remote_ratio
ORDER BY
    median_salary DESC;