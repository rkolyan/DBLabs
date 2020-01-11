--Удалить все альбомы, в которых кол-во треков > 12 && < 24 (DELETE)
DELETE FROM albums AS A
WHERE A.tracks_count BETWEEN 12 AND 24;
