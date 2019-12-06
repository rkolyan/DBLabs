--Триггер INSTEAD OF

DROP VIEW IF EXISTS all_albums_info;

CREATE VIEW all_albums_info AS
SELECT * FROM lab_01.albums
ORDER BY album_id;

CREATE OR REPLACE FUNCTION insert_right_values()
RETURNS TRIGGER AS $emp_stamp$
BEGIN
	IF (NEW.album_id IN (SELECT album_id FROM lab_01.albums))
	THEN
		RAISE EXCEPTION 'This id have been already added';
	ELSIF (NEW.album_id = 0)
	THEN
		RAISE EXCEPTION 'id must be more than 0';
	ELSIF (NEW.musicians_id NOT IN (SELECT musicians_id FROM lab_01.musicians))
	THEN
		RAISE EXCEPTION 'There isnt such musicians_id in musicians';
	ELSIF (NEW.genre_id NOT IN (SELECT genre_id FROM lab_01.genres))
	THEN
		RAISE EXCEPTION 'There isnt such genre_id in genres';
	ELSIF (NEW.label_id NOT IN (SELECT label_id FROM lab_01.labels))
       	THEN
		RAISE EXCEPTION 'There isnt such label_id in labels';
	ELSE
		INSERT INTO lab_01.albums VALUES (NEW.*);
	END IF;
	RETURN NULL;
END;
$emp_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER insert_new_album
	INSTEAD OF INSERT ON all_albums_info
	FOR EACH ROW
	EXECUTE FUNCTION insert_right_values();
