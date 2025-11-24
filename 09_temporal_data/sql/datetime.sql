-- 1. INSPEKTERA TABELLEN
-- Visar kolumnnamn och datatyper för tabellen.
DESC staging.sweden_holidays;

-- Snabbkoll på all data i tabellen (DuckDB-genväg för "SELECT * ...").
FROM
    staging.sweden_holidays;

-- 2. INTERVAL-MATTE (PLUSSA DAGAR)
SELECT
    date,
    -- Lägger till 5 dagar på datumet.
    -- DuckDB förstår automatiskt kalenderregler (t.ex. månadsskiften).
    date + interval 5 day AS plus_5_days,

    -- Kollar vilken datatyp resultatet fick. (Det ska fortfarande vara DATE).
    typeof (plus_5_days) AS plus_5_days_type
FROM
    staging.sweden_holidays;

-- 3. INTERVAL-MATTE (PLUS OCH MINUS)
SELECT
    date,
    date + interval 5 day AS plus_5_days,
    typeof (plus_5_days) AS plus_5_days_type,
    -- Vi kan lika gärna dra bort tid med minus.
    date - interval 5 day AS minus_5_days
FROM
    staging.sweden_holidays;

-- 4. DAGENS DATUM
-- Visar bara dagens datum just nu (ingen koppling till tabellen).
SELECT
    today ();

-- 5. RELATIV TID (HUR LÄNGE SEDAN?)
SELECT
    today () AS today,
    -- Subtraherar 'today' från helgdagens datum.
    -- Resultatet blir ett heltal: Antal dagar mellan nu och helgdagen.
    -- (Negativt tal betyder att helgdagen redan har varit).
    date - today as time_after_holiday,
    *
FROM
    staging.sweden_holidays;

-- 6. VILKEN VECKODAG?
SELECT
    date,
    -- dayname() tar ett datum och ger tillbaka namnet på dagen (t.ex. 'Friday').
    -- Mycket användbart för att filtrera ut helger.
    dayname (date) as weekday
FROM
    staging.sweden_holidays;

-- 7. JÄMFÖRELSE (GREATEST)
SELECT
    *,
    today () as today,
    -- greatest() jämför två värden och väljer det största (senaste datumet).
    -- Här kollar vi: "Vilket ligger längst fram i tiden: helgdagen eller idag?"
    greatest (date, today) as later_dayday
FROM
    staging.sweden_holidays;

-- 8. FORMATERA TILL TEXT (STRFTIME)
SELECT
    date,
    -- strftime = String Format Time.
    -- Gör om datumet (2023-12-24) till en snygg textsträng ("24/12/2023").
    -- %d = dag, %m = månad, %Y = år (4 siffror).
    strftime (date, '%d/%m/%Y') as date_string
FROM
    staging.sweden_holidays;

-- 9. TOLKA FRÅN TEXT (STRPTIME)
SELECT
    date,
    strftime (date, '%d/%m/%Y') as date_string,

    -- strptime = String Parse Time.
    -- Motsatsen till ovan. Tar texten "24/12/2023" och tolkar den som ett datum.
    -- ::DATE på slutet tvingar resultatet att bli datatypen DATE (istället för TIMESTAMP).
    strptime(date_string, '%d/%m/%Y')::DATE as new_date,

    typeof (new_date) -- Bekräftar att det blev ett DATE.
FROM
    staging.sweden_holidays;