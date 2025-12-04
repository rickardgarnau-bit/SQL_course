-- 1. INSPEKTERA TABELLEN
-- Visar "ritningen" för tabellen: vad kolumnerna heter och vilken datatyp de har (t.ex. TIMESTAMP, INTEGER).
DESCRIBE staging.train_schedules;

-- DuckDB-genväg! Samma sak som "SELECT * FROM staging.train_schedules;".
-- Hämtar alla rader och kolumner så att du snabbt ser innehållet.
FROM
    staging.train_schedules;

-- 2. RÄKNA UT TIDSSKILLNAD (INTERVAL)
SELECT
    scheduled_arrival, -- När tåget SKULLE ha kommit
    actual_arrival, -- När tåget FAKTISKT kom
    delay_minutes, -- Förseningen i rena siffror (minuter)
    -- age() räknar ut skillnaden mellan två tidpunkter.
    -- Resultatet blir datatypen INTERVAL (t.ex. "2 minutes" eller "1 hour 5 mins").
    -- Detta är smartare än vanliga siffror eftersom det hanterar datumgränser korrekt.
    age (actual_arrival, scheduled_arrival) as delay_interval,
    -- typeof() är ett felsökningsverktyg.
    -- Här bekräftar vi att resultatet ovan faktiskt blev ett INTERVAL.
    typeof (delay_interval)
FROM
    staging.train_schedules;

-- 3. DAGENS DATUM & TRUNKERING (MINUTER)
SELECT
    -- Hämtar datum och klockslag just nu (lokal tid på din dator).
    current_localtimestamp () as current_time,
    -- date_trunc('minute') kapar bort sekunderna och millisekunderna.
    -- Exempel: "13:45:59" blir "13:45:00". Bra för att städa tidsstämplar.
    date_trunc ('minute', current_time) as min;

-- 4. TRUNKERING (TIMMAR) - GRUNDEN FÖR GRUPPERING
SELECT
    scheduled_arrival,
    -- Detta "nollställer" tiden till närmaste hela timme.
    -- Exempel: Både 14:05 och 14:55 blir 14:00:00.
    -- Detta är SUPERVIKTIGT om du senare vill göra en graf över "Antal tåg per timme".
    date_trunc ('hour', scheduled_arrival) AS scheduled_arrival_trunc
FROM
    staging.train_schedules;

-- 5. EXTRAHERA & FORMATERA TEXT
SELECT
    scheduled_arrival,
    -- extract('hour'...) plockar ut BARA tim-siffran (t.ex. 14) som ett heltal.
    -- Tecknen || fungerar som lim (concatenation).
    -- Vi klistrar ihop texten 'kl. ' med tim-siffran för att få ett snyggt format (t.ex. "kl. 14").
    'kl. ' || extract(
        'hour'
        FROM
            scheduled_arrival
    ) AS scheduled_arrival_hour
FROM
    staging.train_schedules;

-- Uppgift: "Vilken tåg-status (status) är vanligast? Räkna dem och sortera."
SELECT
    status,
    COUNT * as most common
FROM
    staging.train_schedules
GROUP BY
    status
ORDER BY
    most common desc;