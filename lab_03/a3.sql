--Многооператорная табличная функция
CREATE OR REPLACE FUNCTION get_music_group_album_in(record_yeear INT)
RETURNS TABLE (group_name TEXT, album_name TEXT, record_year INT) 
AS $$
	SELECT M.name AS group_name, A.name AS album_name, A.record_year AS record_year
	FROM musicians M
	JOIN albums AS A ON A.musicians_id=M.musicians_id
	WHERE A.record_year = $1;
$$ LANGUAGE SQL;
