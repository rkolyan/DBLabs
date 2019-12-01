SELECT S.fio, S.bucket_count,
	CASE
		WHEN bucket_count=1 THEN 'There is one bucket'
		WHEN bucket_count=2 THEN 'There are two buckets'
		ELSE 'There are more than 2 albums '
	END AS some_bucket_count
FROM 
(
	SELECT F.fio, COUNT(*) AS bucket_count
	FROM florists F
	JOIN buckets AS B ON F.florist_id=B.florist_id
	GROUP BY F.fio
) AS S;
