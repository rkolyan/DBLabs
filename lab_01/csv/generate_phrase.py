import random

#TODO: Create functions:
#def random_album_name()
#def random_musician_type()

#{

def fill_arrays_of_words():
    global articles;
    global pretext;
    global adjectives;
    global verbs;
    global nouns;
    articles = ["A", "The", "To"];
    pretext = ["Of", "In", "Over", "Under", "On", "Near", "Around", "Far From", "Into", "And", "For"];
    adjectives_file =  open("words/adjectives.txt", "r");
    adjectives = adjectives_file.read()[:-1].split(',');
    adjectives_file.close();
    verbs_file = open("words/verbs.txt", "r");
    verbs = verbs_file.read()[:-1].split(',');
    verbs_file.close();
    nouns_file = open("words/nouns.txt", "r");
    nouns = nouns_file.read()[:-1].split(',');
    nouns_file.close();

def create_unusual_word():
    name_prototype = nouns[random.randint(0, len(nouns) - 1)];
    name_prototype.upper();
    name = "";
    if (random.randint(0, 10)):
        for i in range(len(name_prototype)):
            name += name_prototype[i].upper();
            name += ".";
    else:
        num = random.randint(4, 13);
        for i in range(num):
            if (random.randint(0, 1)):
                name += chr(random.randint(ord('a'), ord('z')));
            else:
                name += chr(random.randint(ord('A'), ord('Z')));
    return name;

def create_unusual_phrase(count):
    flags = dict();
    flags['adjective'] = False;
    flags['verb'] = False;
    flags['noun'] = False;
    flags['article_glagol'] = False;
    flags['article_noun'] = False;
    flags['pretext'] = False;
    num = random.randint(0, 5);
    name = ""
    if (not num):
        name = adjectives[random.randint(0, len(adjectives) - 1)];
        name = name[:1].upper() + name[1:];
        flags['adjective'] = True;
    elif (num == 1):
        name = verbs[random.randint(0, len(verbs) - 1)];
        name = name[:1].upper() + name[1:];
        flags['verb'] = True;
    elif (num == 2):
        name = nouns[random.randint(0, len(nouns) - 1)];
        name = name[:1].upper() + name[1:];
        flags['noun'] = True;
    elif (num == 3):
        name = articles[random.randint(0, 1)];
        flags['article_glagol'] = True;
    elif (num == 4):
        name = articles[2];
        flags['article_noun'] = True;
    else:
        name = pretext[random.randint(0, len(pretext) - 1)];
        flags['pretext'] = True;

    for i in range(1, count):
        word = "";
        if (flags['adjective']):
            #TODO: Предыдущее было прилагательным, значит следующее должно быть существительное
            word = nouns[random.randint(0, len(nouns) - 1)];
            flags['noun'] = True;
            flags['adjective'] = False;
        elif (flags['verb']):
            #TODO: Предыдущее было глаголом, значит следующее должно быть либо предлогом, либо артиклем
            num = random.randint(0, 1);
            if (not num):
                word = pretext[random.randint(0, len(pretext) - 1)];
                flags['pretext'] = True;
            else:
                word = "To";
                flags["article_glagol"] = True;
            flags['verb'] = False;
        elif (flags['noun']):
            #TODO: Предыдущее было существительным, значит следующее должно быть предлогом (думаю артикль - хреновая идея)
            num = random.randint(0, 1);
            if (not num):
                word = pretext[random.randint(0, len(pretext) - 1)];
                flags['pretext'] = True;
            else:
                word = articles[random.randint(0, len(articles) - 1)];
                if (word == "To"):
                    flags['article_glagol'] = True;
                else:
                    flags['article_noun'] = True;
            flags['noun'] = False;
        elif (flags['article_glagol'] and i != count - 1):
            #TODO: Предыдущее было "То", поэтому, по идее следующим должен быть глагол, ну либо существ...
            num = random.randint(0, 2)
            if (not num):
                word = adjectives[random.randint(0, len(adjectives) - 1)];
                flags['adjective'] = True;
            elif (num == 1):
                word = verbs[random.randint(0, len(verbs) - 1)];
                flags['verbs'] = True;
            else:
                word = nouns[random.randint(0, len(nouns) - 1)];
                flags['nouns'] = True;
            flags['article_glagol'] = False;
        elif (flags['article_noun'] and i != count - 1):
            #TODO: Предыдущее было "The или A"...
            num = random.randint(0, 1);
            if (not num):
                word = adjectives[random.randint(0, len(adjectives) - 1)];
                flags['adjective'] = True;
            else:
                word = nouns[random.randint(0, len(nouns) - 1)];
                flags['nouns'] = True;
            flags['article_noun'] = False;
        else:
            #TODO: Предыдущее было "In" или другое(предлог, короче)
            num = random.randint(0, 1)
            if (not num):
                word = adjectives[random.randint(0, len(adjectives) - 1)];
                flags['adjective'] = True;
            elif (num == 1):
                word = articles[random.randint(0, 1)];
                flags['article_noun'] = True;
            else:
                word = nouns[random.randint(0, len(nouns) - 1)];
                flags['nouns'] = True;
            flags['pretext'] = False;
        word = word[:1].upper() + word[1:];
        name += ' ' + word;
    if (not random.randint(0, 133)):
        name += '...';
    return name;
#}

def random_phrase():
    num = random.randint(0, 7);
    if (not num):
        return create_unusual_word();
    elif (num == 1):
        name = nouns[random.randint(0, len(nouns) - 1)];
        name = name[:1].upper() + name[1:];
        return name;
    elif (num == 2):
        name1 = adjectives[random.randint(0, len(adjectives) - 1)];
        name1 = name1[:1].upper() + name1[1:];
        name2 = nouns[random.randint(0, len(nouns) - 1)];
        name2 = name2[:1].upper() + name2[1:];
        name = name1 + " " + name2;
        return name;
    else:
        return create_unusual_phrase(num);

def create_array_of_strings(count):
    array = [];
    for i in range(count):
        array.append(random_phrase());
    return array;

def write_in_file(array, count):
    f = open("phrases.txt", "w");
    for i in range(count):
        f.write(array[i] + '\n');
    f.close();

if __name__ == "__main__":
    fill_arrays_of_words();
    count = int(input("Введите кол-во альбомов: "));
    array = create_array_of_strings(count);
    write_in_file(array, count);
