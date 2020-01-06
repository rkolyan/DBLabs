--(UPDATE со скалярным подзапросом в предложении SET)
UPDATE musicians
SET birthyear =
(
	SELECT AVG(birthyear)
	FROM musicians
	WHERE people_count=3
)
WHERE name='Limbo';
