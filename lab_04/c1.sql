--Триггер INSTEAD OF

CREATE EXTENSION plpython3u;

DROP VIEW IF EXISTS all_albums_info;

CREATE VIEW all_albums_info AS
SELECT * FROM albums
ORDER BY album_id;

CREATE OR REPLACE FUNCTION insert_right_values()
RETURNS TRIGGER AS $emp_stamp$
new = TD["new"];
if (not new["album_id"]):
	raise Exception("Album id must be more than 0");

cursor = plpy.cursor("SELECT album_id FROM albums;");
while True:
	rows = cursor.fetch(1);
	if not rows:
		break;
	for row in rows:
		if row["album_id"] == new["album_id"]:
			raise Exception("This album id have been already added");

cursor = plpy.cursor("SELECT musicians_id FROM musicians;");
flag = False;
while True:
	rows = cursor.fetch(10);
	if not len(rows):
		break;
	for row in rows:
		if int(row["musicians_id"]) == int(new["musicians_id"]):
			flag = True;
			break;
if (not flag):
	raise Exception("There isnt such musicians_id in musicians");

cursor = plpy.cursor("SELECT genre_id FROM genres;");
flag = False;
while True:
	rows = cursor.fetch(10);
	if not rows:
		break;
	for row in rows:
		if int(row["genre_id"]) == int(new["genre_id"]):
			flag = True;
			break;
if not flag:
	raise Exception("There isnt such genre_id in genres");

cursor = plpy.cursor("SELECT label_id FROM labels;");
flag = False;
while True:
	rows = cursor.fetch(10);
	if not rows:
		break;
	for row in rows:
		if row["label_id"] == new["label_id"]:
			flag = True;
			break;
if not flag:
	raise Exception("There isnt such label_id in labels");

plpy.execute("INSERT INTO albums VALUES (" + str(new["album_id"]) + ",\'" + str(new["name"]) + "\',\'" + str(new["album_type"]) + "\'," + str(new["tracks_count"]) + "," + str(new["record_year"]) + "," + str(new["musicians_id"]) + "," + str(new["genre_id"]) + "," + str(new["label_id"]) + ");");
$emp_stamp$ LANGUAGE plpython3u;

CREATE TRIGGER insert_new_album
	INSTEAD OF INSERT ON all_albums_info
	FOR EACH ROW
	EXECUTE FUNCTION insert_right_values();
