--(Оконные фикции для устранения дублей)
SELECT T.label_id, T.name
INTO tmp_tab
FROM 
(
	SELECT label_id, name
	FROM lab_01.labels
	UNION ALL
	SELECT label_id, name
	FROM lab_01.labels
) T;

SELECT *
FROM tmp_tab;

SELECT *
INTO res_tab
FROM
(
	SELECT label_id, name,
		ROW_NUMBER() OVER(PARTITION BY label_id ORDER BY label_id) AS row_num
	FROM tmp_tab
) T;
DROP TABLE tmp_tab;

DELETE FROM res_tab
WHERE row_num > 1;

SELECT label_id, name
INTO tmp_tab
FROM res_tab;

TABLE tmp_tab;

DROP TABLE res_tab;
