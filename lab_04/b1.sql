CREATE IF NOT EXISTS EXTENSION plpython3u

DROP IF EXISTS PROCEDURE add_album;

CREATE OR REPLACE PROCEDURE add_album(album_name VARCHAR(200), musicians_name VARCHAR(150), genre_name VARCHAR(150), label_name VARCHAR(150))
AS $$
	def return_musicians_id_in_musicians(name):
		return plpy.execute("SELECT M.musicians_id FROM lab_01.musicians AS M WHERE M.name =\'" + name + "\';");
	
	def return_genre_id_in_genres(name):
		return plpy.execute("SELECT G.genre_id FROM lab_01.genres G WHERE G.name = \'" + name + "\';");
	
	def return_label_id_in_labels(name):
		return plpy.execute("SELECT L.label_id FROM lab_01.labels L WHERE L.name = \'" + name + "\';");
	
	musicians_id = return_musicians_id_in_musicians(musicians_name);
	if (musicians_id == None or not len(musicians_id)):
		print("Не существует исполнителя с названием:", musicians_name, ".");
		return;
	genre_id = return_genre_id_in_genres(genre_name);
	if (genre_id == None or not len(genre_id)):
		print("Не существует жанра с названием:", genre_name, ".");
		return;
	label_id = return_label_id_in_labels(label_name);
	if (label_id == None or not len(label_id)):
		print("Не существует лейбла с названием:", label_name, ".");
		return;
	
	albums_ids = plpy.execute("SELECT album_id FROM lab_01.albums;");
	if (albums_ids == None):
		print("Таблица с альбомами пуста.");
		return;
	maximum = albums_ids[0]["album_id"];
	for i in range(1, len(albums_ids)):
		maximum = max(albums_ids[i]["album_id"], maximum);
	musicians_id = musicians_id[0]["musicians_id"];
	genre_id = genre_id[0]["genre_id"];
	label_id = label_id[0]["label_id"];
	plpy.execute("INSERT INTO lab_01.albums (album_id, name, record_year, tracks_count, album_type, musicians_id, label_id, genre_id) VALUES ("+ str(maximum + 1) + ",\'" + str(album_name) + "\',2019,3,\'EP\'," + str(musicians_id) + "," + str(label_id) + "," + str(genre_id) + ");");
$$ LANGUAGE plpython3u;
