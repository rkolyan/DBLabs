from generate_musicians import fill_strings_from_file, fill_countries

def write_labels_in_labels_csv(array_names, array_countries):
    f = open("labels.csv", "w");
    for i in range(len(array_names)):
        f.write(str(i + 1) + ',');
        f.write('\"' + array_names[i] + '\"' + ',');
        f.write('\"' + array_countries[i] + '\"' + '\n');
    f.close();

if __name__ == "__main__":
    array_names = fill_strings_from_file("words/label_names.txt");
    countries = fill_strings_from_file("words/countries_names.txt");
    array_countries = fill_countries(countries, len(array_names));
    del countries;
    write_labels_in_labels_csv(array_names, array_countries);
