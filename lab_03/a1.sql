--Scalar function
CREATE OR REPLACE FUNCTION get_most_popular_year()
RETURNS INT
AS $$
	SELECT TMP.record_year
	FROM
	(
		SELECT record_year, COUNT(*) AS album_count
		FROM lab_01.albums
		GROUP BY record_year
		ORDER BY album_count DESC
	) TMP
	LIMIT 1
$$ LANGUAGE SQL;
