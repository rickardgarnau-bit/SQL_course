CREATE TABLE IF NOT EXISTS course_content (
  content VARCHAR,
  week INTEGER,
  content_type VARCHAR
);
DELETE FROM course_content;
INSERT INTO course_content (content, week, content_type)
VALUES ('00_intro', 46, 'lecture'),
  ('01_course_structure', 46, 'lecture'),
  ('02_setup_duckdb', 46, 'lecture'),
  ('exercise_0', 46, 'exercise'),
  ('exercise_1', 47, 'exercise'),
  ('lecture_graph', 47, 'lecture'),
  ('tenta', 51, 'exam');
--a) Select all the exercises in this course
SELECT *
FROM course_content
WHERE content_type = 'exercise';
--b) Select all the lectures in this course
SELECT *
FROM course_content
WHERE content_type = 'lecture';
--c) Select all records for week 48
SELECT *
FROM course_content
WHERE week = 48;
--d) Select all records for week 47-49
SELECT *
FROM course_content
WHERE week BETWEEN 47 AND 49;
--e) How many lectures are in the table?
SELECT COUNT(*)
FROM course_content
WHERE content_type = 'lecture';
--f) How many other content are there?
SELECT COUNT(*)
FROM course_content
WHERE content_type != 'lecture';
--g) Which are the unique content types in this table?
SELECT DISTINCT content_type
FROM course_content;
--h) Delete the row with content 02_setup_duckdb and add it again.
DELETE FROM course_content
WHERE content = '02_setup_duckdb';
-----------
SELECT *
FROM course_content;
------------
INSERT INTO course_content (content, week, content_type)
VALUES ('02_setup_duckdb', 46, 'lecture') --i) You see that 02_setup_duckdb comes in the end of your table, even though the week is 46. Now make a query where you sort the weeks in ascending order.
SELECT *
FROM course_content
ORDER BY week;
--j) Now you can choose what you want to explore in this table.