--(SELECT c GROUP BY и HAVING)
SELECT DISTINCT F.fio, COUNT(B.bucket_id)
FROM florists F
JOIN buckets AS B ON B.florist_id=F.florist_id
GROUP BY F.fio, B.bucket_id
HAVING F.fio = 'Burunduk';
