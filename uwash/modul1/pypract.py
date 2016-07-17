#practice of python
# google numpy for R users
## how to execute a py script from python shell

# import os ; os.chdir('c:/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/modul1') ; execfile('pypract.py')


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