#import os ; os.chdir('c:/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/m2-regression') ; execfile('numpy_tutor.py')

#import os ; os.chdir('/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/m2-regression') ; execfile('numpy_tutor.py')

for name in dir():
    if not name.startswith('_'):
        del globals()[name]

import numpy as np 


#create numpy arrays

mylist = [1., 2., 3., 4.]
mynparray = np.array(mylist)
print mynparray

#identiy
one_vector = np.ones(4)
print one_vector
one2Darray = np.ones((2, 4)) # an 2D array with 2 "rows" and 4 "columns"
print one2Darray

zero_vector = np.zeros(4)
print zero_vector

empty_vector = np.empty(5)
print empty_vector

mynparray[0] #accdssing element by index from 0

my_matrix = np.array([[1, 2, 3], [4, 5, 6]])
print my_matrix
print my_matrix[1, 2]

print my_matrix[0:2, 2] # recall 0:2 = [0, 1]   Print a column
print my_matrix[0, 0:3] # print a row

random_vector = np.random.random(10) # 10 random numbers between 0 and 1
print random_vector
fib_indices = np.array([1, 1, 2, 3, 5])
print random_vector[fib_indices]

my_vector = np.array([1, 2, 3, 4])
select_index = np.array([True, False, True, False])
print my_vector[select_index]

select_cols = np.array([True, False, True]) # 1st and 3rd column
select_rows = np.array([False, True]) # 2nd row
print my_matrix[select_rows, :] 
print my_matrix[:, select_cols]

print 'ops on array'
my_array = np.array([1., 2., 3., 4.])
print my_array*my_array
print my_array**2
print my_array - np.ones(4)
print my_array / 3
print my_array / np.array([2., 3., 4., 5.])

print np.sum(my_array)
print np.average(my_array)
print np.sum(my_array)/len(my_array)
print'the dot product'
array1 = np.array([1., 2., 3., 4.])
array2 = np.array([2., 3., 4., 5.])  # 1*2 + 2*3 + 3*4 + 4*5
print np.dot(array1, array2)
print np.sum(array1*array2) # same as np.dot

print 'euclidian distance vector magnitude'
array1_mag = np.sqrt(np.dot(array1, array1))
print array1_mag
print np.sqrt(np.sum(array1*array1)) # same as above


my_features = np.array([[1., 2.], [3., 4.], [5., 6.], [7., 8.]])
print my_features
my_weights = np.array([0.4, 0.5])
print my_weights
my_predictions = np.dot(my_features, my_weights) # note that the weights are on the right
print my_predictions # which has 4 elements since my_features has 4 rows
# np.dot(my_weights, my_features)  # wil fail:.shapes (2,) and (4,2) not aligned:

my_matrix = my_features
my_array = np.array([0.3, 0.4, 0.5, 0.6])
print np.dot(my_array, my_matrix) 

print 'multiply matrices' 
matrix_1 = np.array([[1., 2., 3.],[4., 5., 6.]])
print matrix_1
matrix_2 = np.array([[1., 2.], [3., 4.], [5., 6.]])
print matrix_2
print np.dot(matrix_1, matrix_2)


#end