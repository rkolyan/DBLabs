DROP TABLE IF EXISTS persons CASCADE;
DROP TABLE IF EXISTS holiday_types CASCADE;
DROP TABLE IF EXISTS holidays CASCADE;
DROP TABLE IF EXISTS persons CASCADE;

CREATE TABLE persons
(
	id INT NOT NULL PRIMARY KEY,
	FIO VARCHAR(200)
);

INSERT INTO persons
VALUES (1, 'Головнев Николай Васильевич'),
(2, 'Стропонькин Василий Степанович'),
(3, 'Иванов Петр Сидорович'),
(4, 'Калым Ыж Ныр');

CREATE TABLE holiday_types
(
	id INT NOT NULL PRIMARY KEY,
	htype VARCHAR(200)
);

INSERT INTO holiday_types
VALUES (1, 'За свой счет'),
(2, 'Отпуск'),
(3, 'Больничный');

CREATE TABLE holidays
(
	id INT NOT NULL PRIMARY KEY,
	pid INT NOT NULL REFERENCES persons(id),
	hdate date,
	hid INT NOT NULL REFERENCES holiday_types(id)
);

INSERT INTO holidays
VALUES
(1, 1, '20-01-2020', 1),
(2, 1, '21-01-2020', 1),
(3, 1, '22-01-2020', 1),
(4, 1, '23-01-2020', 1),
(5, 1, '25-01-2020', 3),
(6, 1, '26-01-2020', 3),
(7, 1, '02-02-2020', 1),
(8, 2, '04-02-2020', 2),
(9, 2, '05-02-2020', 2),
(10, 2, '06-02-2020', 2),
(11, 2, '08-04-2020', 3),
(12, 3, '11-01-2020', 1),
(13, 4, '22-02-2020', 3),
(14, 4, '24-02-2020', 3),
(15, 4, '26-02-2020', 3);
