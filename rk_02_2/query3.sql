DROP TABLE IF EXISTS some_table;

CREATE TEMP TABLE some_table AS
(
	SELECT S.name,T.fio 
	FROM subjects AS S
	JOIN teaching_subjects AS TS ON TS.subject_id = S.subject_id
	JOIN teachers AS T ON TS.teacher_id = T.teacher_id
);

TABLE some_table;
