--Триггер AFTER

CREATE OR REPLACE FUNCTION print_old_and_new_row()
RETURNS TRIGGER
AS $emp_audit$
BEGIN
	RAISE NOTICE 'OLD: % % % % % % % %', OLD.album_id, OLD.name, OLD.tracks_count, OLD.album_type, OLD.record_year, OLD.musicians_id, OLD.label_id, OLD.genre_id;
	RAISE NOTICE 'NEW: % % % % % % % %', NEW.album_id, NEW.name, NEW.tracks_count, NEW.album_type, NEW.record_year, NEW.musicians_id, NEW.label_id, NEW.genre_id;
	RETURN NEW;
END;
$emp_audit$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS emp_audit ON lab_01.albums;

CREATE TRIGGER emp_audit
AFTER UPDATE ON lab_01.albums
    FOR EACH ROW EXECUTE PROCEDURE print_old_and_new_row();
