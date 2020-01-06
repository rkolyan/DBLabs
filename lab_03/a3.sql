--Многооператорная табличная функция
CREATE OR REPLACE FUNCTION get_music_group_album_in(INT)
RETURNS TABLE
AS $$
BEGIN
	SELECT M.name AS group_name, A.name AS album_name, A.record_year AS record_year
	FROM musicians M
	JOIN albums AS A ON A.musicians_id=M.musicians_id
	WHERE A.record_year = $1
END
$$ LANGUAGE PLPGSQL;
