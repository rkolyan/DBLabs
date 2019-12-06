--(UPDATE со скалярным подзапросом в предложении SET)
UPDATE buckets
SET florist_id =
(
	SELECT F.florist_id
	FROM florists F
	WHERE fio = 'Djeyms Pont'
)
WHERE name='Blowgun';
