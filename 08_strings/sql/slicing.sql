SELECT 
    sql_word,
    sql_word[0],
    sql_word[1], 
    sql_word[-1]
FROM staging.sql_glossary;

SELECT 
    sql_word,
    sql_word[:2],
    sql_word[2:5]
FROM staging.sql_glossary;