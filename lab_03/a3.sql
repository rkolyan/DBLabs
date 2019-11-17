--Многооператорная табличная функция
CREATE OR REPLACE FUNCTION get_music_group_album_in(INT)
RETURNS RECORD
AS $$
BEGIN
	SELECT M.name AS group_name, A.name AS album_name, A.record_year AS record_year
	FROM lab_01.musicians M
	JOIN lab_01.albums AS A ON A.musicians_id=M.musicians_id
	WHERE A.record_year = $1
END
$$ LANGUAGE PLPGSQL;