#practice of python
# google numpy for R users
## how to execute a py script from python shell

# import os ; os.chdir('c:/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/modul1') ; execfile('pypract.py')

# import os ; os.chdir('/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/modul1') ; execfile('pypract.py')


# graphlab doc
# https://turi.com/learn/translator/   #sfame vs panda





print os.getcwd()

import graphlab

#load data in sframe
sf = graphlab.SFrame('people-example.csv')

print sf 

print 'sf.head(3)'
print sf.head(3)

#print "sf['age'].show(view='Categorical')  # opens in a browser"
#print sf['age'].show(view='Categorical')

print sf['age'].mean()
sf['age'].max() 

print 'creating new columnt in sf'
sf['Full Name'] = sf['First Name'] + ' ' + sf['Last Name']
print sf.head(2)

### definnig a function
print 'defining a function'
def transform_country(country):
    if country == 'USA':
        return 'United States'
    else:
        return country

print 'applying more complex function'
def  myfunc(x, y):
    out = 'NA'
    if x =="USA":
        out = "United States"
    else:
        out = x
    if y == 'na':
        out = 'NA'
    return out  

sf['Country_nn'] =sf['Country'].apply(lambda x: myfunc(x,'na')  )

print sf.head(2) 

print 'nrow of sframe: ' + str(len(sf))
print 'nrow of sframe with num_rows: ' + str(sf.num_rows())


print "applying sf['Country_n'] = sf['Country'].apply(transform_country) "
sf['Country_n'] = sf['Country'].apply(transform_country)
print sf.head(2)        


##how to check first row as a list 
print sf[0]

### how words can be counted  for each row in a particular columns
sf['count_words']  =  graphlab.text_analytics.count_words(sf['Country'])
print sf['count_words']

#convert a dictionary sf['count_woreds'] into a table 
sf_wc_table =  sf[['count_words']].stack('count_words', new_column_name = ['word','count'])
print sf_wc_table

#tf-idf compuation
tfidf = graphlab.text_analytics.tf_idf(sf['count_words'])

## how to have unique values in array
print "unique values of array " +  str(sf['age'].unique())


## how to sort sf on specific column
sf.sort('age', ascending=False)

##############################################
### m1 w5 specific
##############################################

song_data = graphlab.SFrame('song_data.gl/')

users = song_data['user_id'].unique()

# q 1
l_kw = len(song_data[song_data['artist']=='Kanye West']['user_id'].unique())
l_ff  = len(song_data[song_data['artist']=='Foo Fighters']['user_id'].unique())
l_ts  = len(song_data[song_data['artist']=='Taylor Swift']['user_id'].unique())
l_lg  = len(song_data[song_data['artist']=='Lady GaGa']['user_id'].unique())

# q2
song_data_gr = song_data.groupby(key_columns='artist', operations={'total_count': graphlab.aggregate.SUM('listen_count')})

#most popular
song_data_gr.sort('total_count', ascending=False).head()

#least popular
song_data_gr.sort('total_count', ascending=True).head()

#q 3
train_data,test_data = song_data.random_split(.8,seed=0)
subset_test_users = test_data['user_id'].unique()[0:10000]
#rcmd_songs = personalized_model.recommend(subset_test_users,k=1)

##############################################
##### m1 w6 specific
##############################################
image_train = graphlab.SFrame('image_train_data/')
image_test = graphlab.SFrame('image_test_data/')

raw_pixel_model = graphlab.logistic_classifier.create(image_train,target='label',features=['image_array'])
image_test[0:3]['label']
raw_pixel_model.predict(image_test[0:3])

knn_model = graphlab.nearest_neighbors.create(image_train,features=['deep_features'],label='id')

## for quizes 
# q1
image_train['label'].sketch_summary()

#q2
bird_train = image_train[image_train['label']=='bird']
dog_train = image_train[image_train['label']=='dog']
cat_train = image_train[image_train['label']=='cat']
auto_train = image_train[image_train['label']=='automobile']


bird_model = graphlab.nearest_neighbors.create(bird_train,features=['deep_features'],label='id')
dog_model = graphlab.nearest_neighbors.create(dog_train,features=['deep_features'],label='id')
cat_model = graphlab.nearest_neighbors.create(cat_train,features=['deep_features'],label='id')
auto_model = graphlab.nearest_neighbors.create(auto_train,features=['deep_features'],label='id')


cat = image_test[0:1]
cat_model.query(cat )
dog_model.query(cat )

#q3 
cat_model.query(image_test[0:1] )['distance'].mean()
dog_model.query(image_test[0:1] )['distance'].mean()

#q4
bird_test = image_test[image_test['label']=='bird']
dog_test = image_test[image_test['label']=='dog']
cat_test = image_test[image_test['label']=='cat']
auto_test = image_test[image_test['label']=='automobile']


dog_cat_neighbors = cat_model.query(dog_test, k=1)
dog_dog_neighbors = dog_model.query(dog_test, k=1)
dog_bird_neighbors = bird_model.query(dog_test,k=1)
dog_auto_neighbors = auto_model.query(dog_test,k=1)



dog_distances = graphlab.SFrame( {'query_label':dog_dog_neighbors['query_label']
                                 ,'dog_dog_dist': dog_dog_neighbors['distance']
                                 ,'dog_cat_dist': dog_cat_neighbors['distance']
                                 ,'dog_bird_dist': dog_bird_neighbors['distance']
                                 ,'dog_auto_dist': dog_auto_neighbors['distance'] })


def is_dog_correct(x) :
    if min([ x['dog_auto_dist'], x['dog_bird_dist'],  x['dog_cat_dist'], x['dog_dog_dist']] ) == x['dog_dog_dist']  :
        return 1
    else:
        return 0
        
print 'dog_accuracy: ' + str( dog_distances.apply(is_dog_correct).sum() )


## redo for cats
cat_cat_neighbors = cat_model.query(cat_test, k=1)
cat_dog_neighbors = dog_model.query(cat_test, k=1)
cat_bird_neighbors = bird_model.query(cat_test,k=1)
cat_auto_neighbors = auto_model.query(cat_test,k=1)


cat_distances = graphlab.SFrame( {'query_label':cat_cat_neighbors['query_label']
                                 ,'cat_dog': cat_dog_neighbors['distance']
                                 ,'cat_cat': cat_cat_neighbors['distance']
                                 ,'cat_bird': cat_bird_neighbors['distance']
                                 ,'cat_auto': cat_auto_neighbors['distance'] })

def is_cat_correct(x) :
    if min([ x['cat_auto'], x['cat_bird'],  x['cat_cat'], x['cat_dog']] ) == x['cat_cat']  :
        return 1
    else:
        return 0

print 'cat_accuracy: ' + str( cat_distances.apply(is_cat_correct).sum() )


## end