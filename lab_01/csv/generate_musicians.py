from random import randint

def fill_strings_from_file(name):
    musician_names = []
    f = open(name, "r");
    for line in f:
        musician_names.append(line[:-1]);
    f.close();
    return musician_names;

def fill_people_counts(count):
    array = [];
    for i in range(count):
        array.append(randint(1, 6));
    return array;

def fill_years(count):
    array = [];
    for i in range(count):
        array.append(randint(1970, 2020));
    return array;

def fill_dead_bits(count):
    array = [];
    for i in range(count):
        num = randint(0, 10);
        if (num):
            array.append(0);
        else:
            array.append(1);
    return array;

def fill_countries(countries, count):
    array = [];
    for i in range(count):
        array.append(countries[randint(0, len(countries) - 1)]);
    return array;

def write_all_in_musicians_csv(names, people_countes, years, array_is_dead, countries):
    f = open("musicians.csv", "w");
    for i in range(len(names)):
        f.write(str(i + 1) + ',');
        f.write('\"' + names[i] + '\"' + ',');
        f.write(str(people_countes[i]) + ',');
        f.write(str(years[i]) + ',');
        f.write(str(array_is_dead[i]) + ',');
        f.write('\"' + countries[i] + '\"' + '\n');
    f.close();


if __name__ == "__main__":
    array_names = fill_strings_from_file("words/musician_names.txt");
    array_people_count = fill_people_counts(len(array_names));
    array_years = fill_years(len(array_names));
    array_is_dead = fill_dead_bits(len(array_names));
    countries = fill_strings_from_file("words/countries_names.txt");
    array_countries = fill_countries(countries, len(array_names));
    del countries;
    write_all_in_musicians_csv(array_names, array_people_count, array_years, array_is_dead, array_countries);
