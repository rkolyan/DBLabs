CREATE SCHEMA IF NOT EXISTS lab_01;

DROP TABLE IF EXISTS lab_01.Albums;
DROP TABLE IF EXISTS lab_01.Musicians;
DROP TABLE IF EXISTS lab_01.Labels;
DROP TABLE IF EXISTS lab_01.Genres;

CREATE TABLE lab_01.Musicians
(
	musicians_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	people_count INT NOT NULL,
	birthyear INT,
	is_dead BIT,
	country VARCHAR(100)
);

ALTER TABLE lab_01.Musicians ADD CONSTRAINT UI_M UNIQUE(musicians_id);
ALTER TABLE lab_01.Musicians ADD CONSTRAINT CH_M_NAME CHECK(name <> '');

\copy lab_01.Musicians FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/musicians.csv' WITH (FORMAT csv);

CREATE TABLE lab_01.Genres
(
	genre_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	birth_years VARCHAR(30)
);

ALTER TABLE lab_01.Genres ADD CONSTRAINT UI_G UNIQUE(genre_id);
ALTER TABLE lab_01.Genres ADD CONSTRAINT CH_G_NAME CHECK(name <> '');

\copy lab_01.Genres FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/genres.csv' WITH (FORMAT csv);

CREATE TABLE lab_01.Labels
(
	label_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	country VARCHAR(100)
);

ALTER TABLE lab_01.Labels ADD CONSTRAINT UI_L UNIQUE(label_id);
ALTER TABLE lab_01.Labels ADD CONSTRAINT CH_L_NAME CHECK(name <> '');

\copy lab_01.Labels FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/labels.csv' WITH (FORMAT csv);

CREATE TABLE lab_01.Albums
(
	album_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(200),
	album_type VARCHAR(3),
	record_year int,
	tracks_count INT,
	musicians_id INT NOT NULL REFERENCES lab_01.Musicians(musicians_id),
	label_id INT NOT NULL REFERENCES lab_01.Labels(label_id),
	genre_id INT NOT NULL REFERENCES lab_01.Genres(genre_id)
);

ALTER TABLE lab_01.Albums ADD CONSTRAINT UI_A UNIQUE(album_id);
ALTER TABLE lab_01.Albums ADD CONSTRAINT CH_A_NAME CHECK(name <> '');
ALTER TABLE lab_01.Albums ADD CONSTRAINT CH_MINUS_TRACKS CHECK(tracks_count > 0);
ALTER TABLE lab_01.Albums ADD CONSTRAINT CH_YEAR CHECK(record_year < 2021 and record_year > -1);

\copy lab_01.Albums FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/albums.csv' WITH (FORMAT csv);
