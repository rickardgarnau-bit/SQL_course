DESCRIBE staging.train_schedules;

FROM
    staging.train_schedules;

SELECT
    scheduled_arrival,
    actual_arrival,
    delay_minutes,
    age (actual_arrival, scheduled_arrival) as delay_interval,
    typeof (delay_interval)
FROM
    staging.train_schedules;

--
SELECT
    current_localtimestamp () as current_time,
    date_trunc ('minute', current_time) as min;

--
SELECT
    scheduled_arrival,
    date_trunc ('hour', scheduled_arrival) AS scheduled_arrival_trunc
FROM
    staging.train_schedules;