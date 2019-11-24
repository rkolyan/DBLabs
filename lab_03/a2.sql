--Подставляемая табличная функция
CREATE OR REPLACE FUNCTION get_music_group_album_in(INT)
RETURNS TABLE (group_name VARCHAR(150), album_name VARCHAR(200), year INT)
AS $$
	SELECT M.name, A.name, A.record_year
	FROM lab_01.musicians M
	JOIN lab_01.albums AS A ON A.musicians_id=M.musicians_id
	WHERE A.record_year = $1
$$ LANGUAGE SQL;
