-- a)
CREATE TABLE cleaned_salaries AS
SELECT
    * REPLACE (
        CASE
            WHEN employment_type = 'CT' THEN 'Contract'
            WHEN employment_type = 'FL' THEN 'Freelance'
            WHEN employment_type = 'PT' THEN 'Part time'
            WHEN employment_type = 'FT' THEN 'Full time'
            ELSE employment_type -- Om det dyker upp något annat, behåll originalet
        END AS employment_type
    )
FROM
    read_csv_auto('data/salaries.csv');

-- b)
UPDATE
    cleaned_salaries
SET
    company_size = CASE
        WHEN company_size = 'L' THEN 'Large'
        WHEN company_size = 'M' THEN 'Medium'
        WHEN company_size = 'S' THEN 'Small'
        ELSE company_size
    END;

-- c)
ALTER TABLE
    cleaned_salaries
ADD
    COLUMN salary_sek INTEGER;

UPDATE
    cleaned_salaries
SET
    salary_sek = salary_in_usd * 10.9;

-- d)
ALTER TABLE
    cleaned_salaries
ADD
    COLUMN monthly_salary_sek INTEGER;

UPDATE
    cleaned_salaries
SET
    monthly_salary_sek = salary_sek / 12;

-- e)
ALTER TABLE
    cleaned_salaries
ADD
    COLUMN salary_level VARCHAR;

UPDATE
    cleaned_salaries
SET
    salary_level = CASE
        WHEN monthly_salary_sek < 25000 THEN 'low'
        WHEN monthly_salary_sek BETWEEN 25000
        AND 45000 THEN 'medium'
        WHEN monthly_salary_sek BETWEEN 45001
        AND 80000 THEN 'high'
        ELSE 'insanely_high'
    END;

-- f)
CREATE
OR REPLACE TABLE cleaned_salaries AS
SELECT
    experience_level,
    employment_type,
    job_title,
    salary_sek AS salary_annual_sek,
    monthly_salary_sek AS salary_monthly_sek,
    remote_ratio,
    company_size,
    salary_level
FROM
    cleaned_salaries;

-- g) 
UPDATE
    cleaned_salaries
SET
    experience_level = CASE
        WHEN experience_level = 'EN' THEN 'Entry-level'
        WHEN experience_level = 'MI' THEN 'Mid-level'
        WHEN experience_level = 'SE' THEN 'Senior'
        WHEN experience_level = 'EX' THEN 'Executive'
        ELSE experience_level
    END;