import random

def count_info_from_files():
    global genres_count;
    global musicians_count;
    global labels_count;
    genres_count = 0;
    musicians_count = 0;
    labels_count = 0;

    tmpfile = open("genres.csv");
    for line in tmpfile:
        genres_count += 1;
    tmpfile.close();
    tmpfile = open("musicians.csv");
    for line in tmpfile:
        musicians_count += 1;
    tmpfile.close();
    tmpfile = open("labels.csv");
    for line in tmpfile:
        labels_count += 1;
    tmpfile.close();

def random_album_type():
    num = random.randint(0, 4);
    if (not num):
        return "SP";
    elif (num == 1):
        return "EP";
    elif (num == 2):
        return "LP";
    elif (num == 3):
        return "DLP";
    else:
        return "TLP";

def random_num(num):
    return random.randint(1, num);

def fill_random_name_array_from_file():
    global phrases;
    phrases = list();
    tmpfile = open("phrases.txt", "r");
    for line in tmpfile:
        phrases.append(line[:-1]);
    tmpfile.close();

def get_album_name(i):
    return phrases[i];

def generate_albums(count):
    array = list();
    for i in range(count):
        array.append([i + 1, get_album_name(i), random_album_type(),
            random.randint(1970, 2020), 0, random_num(musicians_count),
            random_num(labels_count), random_num(genres_count)]);
        if (array[i][2] == "SP"):
            array[i][4] = 1;
        elif (array[i][2] == "EP"):
            array[i][4] = random.randint(2, 6);
        elif (array[i][2] == "LP"):
            array[i][4] = random.randint(7, 14);
        elif (array[i][2] == "DLP"):
            array[i][4] = random.randint(15, 33);
        else:
            array[i][4] = random.randint(34, 50);
    return array;

def write_all_in_albums_csv(array):
    tmpfile = open("albums.csv", "w");
    for i in range(len(array)):
        subarray = array[i];
        tmpfile.write(str(subarray[0]) + ',' + '\"' + subarray[1] + '\"' + ',' + subarray[2] + ',' + str(subarray[3]) + ',' + str(subarray[4]) + ',' + str(subarray[5]) + ',' + str(subarray[6]) + ',' + str(subarray[7]) + '\n');
    tmpfile.close();

if __name__ == "__main__":
    count_info_from_files();
    fill_random_name_array_from_file();
    count = int(input("Input count of albums, please: "));
    array = generate_albums(count);
    write_all_in_albums_csv(array);
