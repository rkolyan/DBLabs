DROP TABLE IF EXISTS enterexit CASCADE;
DROP TABLE IF EXISTS employers CASCADE;

CREATE TABLE employers
(
	employer_id INT NOT NULL PRIMARY KEY,
	fio VARCHAR(200),
	birthdate date,
	department VARCHAR(100)
);


CREATE TABLE enterexit
(
	employer_id INT NOT NULL REFERENCES employers(employer_id),
	ddate date,
	day VARCHAR(20),
	ttime time
	ttype smallint
);
