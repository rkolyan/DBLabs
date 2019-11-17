--Триггер AFTER

DROP TABLE IF EXISTS history_of_changes;

CREATE TABLE history_of_changes (
	user_name VARCHAR(100),
	action	VARCHAR(6)
);	

CREATE OR REPLACE FUNCTION add_entry()
RETURNS TRIGGER AS $emp_stamp$
BEGIN
	INSERT INTO history_of_changes VALUES (user, TG_OP);
	RETURN NULL;
END;
$emp_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER print_info
	AFTER INSERT OR DELETE OR UPDATE ON lab_01.albums
	FOR EACH ROW
	EXECUTE FUNCTION print_message();
