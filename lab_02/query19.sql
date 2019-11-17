--(UPDATE со скалярным подзапросом в предложении SET)
UPDATE lab_01.musicians
SET birthyear =
(
	SELECT AVG(birthyear)
	FROM lab_01.musicians
	WHERE people_count=3
)
WHERE name='Limbo';
