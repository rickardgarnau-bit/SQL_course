SELECT
    *
FROM
    plants p
    LEFT JOIN plant_care pc USING (plant_id);

SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM
    plants p
    LEFT JOIN main.plant_care pc ON p.plant_id = pc.plant_id;

SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM
    plants p
    LEFT JOIN main.plant_care pc ON p.plant_id = pc.plant_id;

SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM
    plants p
    RIGHT JOIN main.plant_care pc ON p.plant_id = pc.plant_id;

SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM
    plants p
    FULL JOIN main.plant_care pc ON p.plant_id = pc.plant_id;

SELECT
    p.plant_id,
    p.plant_name,
    p.type,
    pc.water_schedule,
    pc.sunlight
FROM
    plants p
    CROSS JOIN plant_care pc;