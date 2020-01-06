--Триггер AFTER

DROP TABLE IF EXISTS emp_audit;

CREATE TABLE emp_audit(
	operation         char(1)   NOT NULL,
	stamp             timestamp NOT NULL,
	userid            text      NOT NULL,
	album_id 	  INT,
	album_name	  text,
	album_type	  text,
	record_year	  INT,
	tracks_count	  INT,
	musicians_id	  INT,
	label_id	  INT,
	genre_id	  INT
);

CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO emp_audit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO emp_audit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO emp_audit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL;
    END;
$emp_audit$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS emp_audit ON albums;

CREATE TRIGGER emp_audit
AFTER INSERT OR UPDATE OR DELETE ON albums
    FOR EACH ROW EXECUTE PROCEDURE process_emp_audit();
