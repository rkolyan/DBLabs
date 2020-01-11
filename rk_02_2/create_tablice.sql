DROP TABLE IF EXISTS cathedral CASCADE;
DROP TABLE IF EXISTS teachers CASCADE;
DROP TABLE IF EXISTS subjects CASCADE;
DROP TABLE IF EXISTS teaching_subjects;

CREATE TABLE cathedral
(
	cathedral_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(10),
	subscribtion VARCHAR(300)
);

CREATE TABLE teachers
(
	teacher_id INT NOT NULL PRIMARY KEY,
	fio VARCHAR(300),
	pow VARCHAR(200),
	profession VARCHAR(200),
	cathedral_id INT NOT NULL REFERENCES cathedral(cathedral_id)
);

CREATE TABLE subjects
(
	subject_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(300),
	hour_count SMALLINT,
	semester SMALLINT,
	rating INT
);

CREATE TABLE teaching_subjects
(
	teacher_id INT NOT NULL REFERENCES teachers(teacher_id),
	subject_id INT NOT NULL REFERENCES subjects(subject_id)
);
