
#the_answer = "42

def first_elts (input_lst):
    elts = []
    for each in input_lst:
        elts.append(each)
    return elts

lives = [1,2,3]
first_life = lives[0]

f = open("story.txt")
story = f.read()
split_story=story.split(" ")



print(first_life)
print(split_story[0])

### prepare movie data
fn = "movie_metadata.csv"
with open(fn, mode="rt",encoding='utf-8') as f:
    movie_data = [ line.split('\n')[0].split(',') for line in f.readlines() ]

del movie_data[0]

def summary_statistics(input_lst):
    num_japan_films = feature_counter(input_lst,6,"Japan",True)
    num_color_films = feature_counter(input_lst,2,"Color",True)
    num_films_in_english = feature_counter(input_lst,5,"English",True)
    summary_dict = {"japan_films" : num_japan_films, "color_films" : num_color_films, "films_in_english" : num_films_in_english}
    return summary_dict

def feature_counter(input_lst,index, input_str, header_row = False):
    num_elt = 0
    if header_row == True:
        input_lst = input_lst[1:len(input_lst)]
    for each in input_lst:
        if each[index] == input_str:
            num_elt = num_elt + 1
    return num_elt

summary = summary_statistics(movie_data)
print(summary)

