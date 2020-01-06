--Здесь должен быть аналог for xml auto, path, explicit
SELECT
    XMLCONCAT('<!--Just an xmlresult-->', E'\n', XMLFOREST(tb1."xml-val" as "Genres"), E'\n') AS xmlresult
FROM
    (
        SELECT
           XMLAGG(XMLELEMENT(NAME genre, XMLATTRIBUTES(G.genre_id AS id, G.name as name), E'\n')) AS
            "xml-val"
        FROM
            genres AS G
    ) AS tb1;
