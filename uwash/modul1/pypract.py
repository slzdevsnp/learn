#practice of python
# google numpy for R users
## how to execute a py script from python shell

# import os ; os.chdir('c:/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/modul1') ; execfile('pypract.py')


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




print "applying sf['Country_n'] = sf['Country'].apply(transform_country) "
sf['Country_n'] = sf['Country'].apply(transform_country)
print sf.head(2)        




