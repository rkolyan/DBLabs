DROP TABLE IF EXISTS xmldata;
CREATE TABLE xmldata(data xml);
\copy xmldata from '/home/nikolay/DesktopW/DBLabs/lab_05/b1.xml';

CREATE OR REPLACE FUNCTION xml_parse_to_musicians()
RETURNS BOOLEAN AS
$$
BEGIN
	IF (SELECT COUNT(data) from xmldata) = 0 THEN
		RAISE EXCEPTION 'There isnt file with this name or path';
		RETURN FALSE;
	END IF;
	INSERT INTO lab_01.musicians
	SELECT unnest((xpath('//musicians/musicians_id/text()', data)::varchar[])::integer[]),
		unnest(xpath('//musicians/name/text()', data)::varchar[]),
		unnest((xpath('//musicians/people_count/text()', data)::varchar[])::integer[]),
		unnest((xpath('//musicians/birthyear/text()', data)::varchar[])::integer[]),
		unnest((xpath('//musicians/is_dead/text()', data)::varchar[])::bit[]),
		unnest(xpath('//musicians/country/text()', data)::varchar[])
	FROM xmldata;
	RETURN TRUE;
END
$$ LANGUAGE PLPGSQL;

DELETE FROM lab_01.musicians AS M
WHERE M.musicians_id > 1999;
