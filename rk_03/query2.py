import psycopg2 as pg

def find_delta_time(string1, string2):
    return (int(string2) - int(string1)) % 24;

if __name__ == "__main__":
    connection = pg.connect("db=labs user=nikolay");
    cursor = connection.cursor();

    cursor.execute('SELECT * FROM employers;');
    all_employers = cursor.fetchall();
    cursor.execute('SELECT * FROM enterexit;');
    all_enterexit = cursor.fetchall();
    
    #Query
    tmp1 = [array for array in all_enterexit if array[4] == 1];
    tmp2 = [array for array in all_enterexit if array[4] == 2];
    tmp = [];
    for tmpi1 in tmp1:
        for tmpi2 in tmp1:
            if (tmpi1[0] == tmpi2[0]):
                tmp.append(tmpi1 + tmpi2[1:]);
    tmp_tmp = [];
    for tmpi in tmp:
        if (find_delta_time[tmpi[1], tmpi[6]] < 8)
            tmp_tmp.append(tmpi);
    #Здесь заканчивается поиск тех, кто ходит менее 8 часов
    query2 = reduce() / len(tmp);
