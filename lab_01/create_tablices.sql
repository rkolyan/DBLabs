DROP TABLE IF EXISTS Albums;
DROP TABLE IF EXISTS Musicians;
DROP TABLE IF EXISTS Labels;
DROP TABLE IF EXISTS Genres;

CREATE TABLE Musicians
(
	musicians_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	people_count INT NOT NULL,
	birthyear INT,
	is_dead BIT,
	country VARCHAR(100)
);

ALTER TABLE Musicians ADD CONSTRAINT UI_M UNIQUE(musicians_id);
ALTER TABLE Musicians ADD CONSTRAINT CH_M_NAME CHECK(name <> '');

\copy Musicians FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/musicians.csv' WITH (FORMAT csv);

CREATE TABLE Genres
(
	genre_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	birth_years VARCHAR(30)
);

ALTER TABLE Genres ADD CONSTRAINT UI_G UNIQUE(genre_id);
ALTER TABLE Genres ADD CONSTRAINT CH_G_NAME CHECK(name <> '');

\copy Genres FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/genres.csv' WITH (FORMAT csv);

CREATE TABLE Labels
(
	label_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(150),
	country VARCHAR(100)
);

ALTER TABLE Labels ADD CONSTRAINT UI_L UNIQUE(label_id);
ALTER TABLE Labels ADD CONSTRAINT CH_L_NAME CHECK(name <> '');

\copy Labels FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/labels.csv' WITH (FORMAT csv);

CREATE TABLE Albums
(
	album_id INT NOT NULL PRIMARY KEY,
	name VARCHAR(200),
	album_type VARCHAR(3),
	record_year int,
	tracks_count INT,
	musicians_id INT NOT NULL REFERENCES Musicians(musicians_id),
	label_id INT NOT NULL REFERENCES Labels(label_id),
	genre_id INT NOT NULL REFERENCES Genres(genre_id)
);

ALTER TABLE Albums ADD CONSTRAINT UI_A UNIQUE(album_id);
ALTER TABLE Albums ADD CONSTRAINT CH_A_NAME CHECK(name <> '');
ALTER TABLE Albums ADD CONSTRAINT CH_MINUS_TRACKS CHECK(tracks_count > 0);
ALTER TABLE Albums ADD CONSTRAINT CH_YEAR CHECK(record_year < 2021 and record_year > -1);

\copy Albums FROM '/home/nikolay/DesktopW/DBLabs/lab_01/csv/albums.csv' WITH (FORMAT csv);
