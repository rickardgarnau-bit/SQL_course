-- remove leading and trailing spaces
SELECT
    trim(sql_word, ' ') as trimmed_word,
    trimmed_word[1] as first_character,
    trimmed_word[-1] as last_character,
FROM
    staging.sql_glossary;

-- tranform character to uppercase
SELECT
    upper(trim(sql_word, ' ')) as sql_term,
    sql_term[1] as first_character,
    sql_term[-1] as last_character,
FROM
    staging.sql_glossary;

-- replace 2 or more spaces with 1 space
SELECT
    description,
    replace(description, '  ', ' ') as cleaned_description
FROM staging.sql_glossary;

-- concatenate strings with ||
SELECT
    concat(upper(trim(sql_word)), ' command') as sql_command_func,
    upper(trim(sql_word)) || ' command' as sql_command_pipe
FROM
    staging.sql_glossary;


-- extract substrings
SELECT
    trim(sql_word, ' ') as trimmed_word,
    substring(trim(sql_word),1,5) as first_five_chars,
    trimmed_word[1:5] as sliced_five_chars,
FROM
    staging.sql_glossary;

-- extract substrings
SELECT
    reverse(trim(sql_word)) as reversed_word,
FROM
    staging.sql_glossary; 

-- find position of first occurence of a substring
-- return 0 if substring is not found
SELECT
description,
instr(description, 'select') as select_position,
select_position != 0 as about_select
FROM staging.sql_glossary;