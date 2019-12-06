--Хранимая процедура с курсором

CREATE OR REPLACE FUNCTION find_count_of_albums_of_musicians(musicians_name VARCHAR(150))
RETURNS INT
AS $$
	DECLARE
		album_count numeric;
		_musicians_id numeric;
		_tmp_id numeric;
		curs1 CURSOR FOR SELECT * FROM lab_01.albums WHERE musicians_id = _musicians_id;
BEGIN
	_musicians_id := (SELECT M.musicians_id FROM lab_01.musicians AS M WHERE M.name = musicians_name);
	album_count := 0;
	OPEN curs1;
	LOOP
	FETCH curs1 INTO _tmp_id;
	IF NOT FOUND 
		THEN EXIT;
	END IF;
	album_count := album_count + 1;
	END LOOP;
	CLOSE curs1;
	RETURN album_count;
END;
$$ LANGUAGE PLPGSQL;
