#import os ; os.chdir('c:/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/m2-regression') ; execfile('m2pypract.py')

#import os ; os.chdir('/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/m2-regression') ; execfile('m2pypract.py')

for name in dir():
    if not name.startswith('_'):
        del globals()[name]

import os;

print os.getcwd()

import graphlab 
#import sframe as sf
import numpy as np 
import pandas as pnd 



##w1 quiz

sales = graphlab.SFrame('kc_house_data.gl/')
print 'sales number of rows: ' + str(sales.num_rows())
train_data,test_data = sales.random_split(.8,seed=0)
#just the price column
prices = sales['price'] # extract the price column of the sales SFrame -- this is now an SArray
sum_prices = prices.sum()
num_houses = prices.size()
avg_price_1 = sum_prices/num_houses
avg_price_2 = prices.mean()
print 'avg prices method 1: ' + str(avg_price_1) + ' and 2: ' + str(avg_price_2)
prices_squared = prices*prices
sum_prices_squared = prices_squared.sum() 
print "the sum of price squared is: " + str(sum_prices_squared)

#closed form linear regression in a func
def simple_linear_regression(xvec, yvec):
    slope = ( (xvec*yvec).mean()  - xvec.mean() * yvec.mean() ) / \
            ( (xvec*xvec).mean() - xvec.mean() * xvec.mean() ) 
    intercept = yvec.mean() - slope * xvec.mean()
    return (intercept, slope)

## to test on artifical inputs (expect 1 and 1)
test_feature = graphlab.SArray(range(5))
test_output = graphlab.SArray(1 + 1*test_feature)
(test_intercept, test_slope) =  simple_linear_regression(test_feature, test_output)
print "Intercept: " + str(test_intercept)
print "Slope: " + str(test_slope)

## check w0 and w1 from train data
sqft_intercept, sqft_slope = simple_linear_regression(train_data['sqft_living'], train_data['price'])

print "Intercept: " + str(sqft_intercept)
print "Slope: " + str(sqft_slope)

def get_regression_predictions(input_feature, intercept, slope):
    predicted_values = intercept + slope * input_feature
    return predicted_values
## quiz question
my_house_sqft = 2650
estimated_price = get_regression_predictions(my_house_sqft, sqft_intercept, sqft_slope)
print "quiz: The estimated price for a house with %d squarefeet is: $%.2f" % (my_house_sqft, estimated_price)



#### rss
def get_residual_sum_of_squares(input_feature, output, intercept, slope):
    RSS = ((output - (intercept + slope*input_feature))**2).sum()
    return(RSS)    

#test rss
print 'test rss on know inputs, expect rss=0: ' \
+ str( get_residual_sum_of_squares(test_feature,test_output,1.0,1.0) ) 

##quiz on rss 
rss_prices_on_sqft = get_residual_sum_of_squares(train_data['sqft_living'], train_data['price'], sqft_intercept, sqft_slope)
print 'The RSS of predicting Prices based on Square Feet is : ' + str(rss_prices_on_sqft)


##inverse regression
def inverse_regression_predictions(output, intercept, slope):
    estimated_feature = 1.0/slope * (output - intercept ) 
    return estimated_feature

print( 'inverse regression on artificial feature:  ' + str(inverse_regression_predictions(test_output,1.0,1.0)))

## quiz
my_house_price = 800000
estimated_squarefeet = inverse_regression_predictions(my_house_price, sqft_intercept, sqft_slope)
print "quiz The estimated squarefeet for a house worth $%.2f is %d" % (my_house_price, estimated_squarefeet)


### predicting from  bedrooms
bedr_intercept, bedr_slope = simple_linear_regression(train_data['bedrooms'], train_data['price'])
print "Intercept: " + str(bedr_intercept)
print "Slope: " + str(bedr_slope)

### compare rss on test data
rss_prices_on_bedr = get_residual_sum_of_squares(test_data['bedrooms'], test_data['price'], bedr_intercept, bedr_slope)
print 'The test_data RSS of predicting Prices based on n. bedrooms is : ' + str(rss_prices_on_bedr)

rss_prices_on_sqft_t = get_residual_sum_of_squares(test_data['sqft_living'], test_data['price'], sqft_intercept, sqft_slope)
print 'The test_data RSS of predicting Prices based on Square Feet is : ' + str(rss_prices_on_sqft)

###### week2
print '####################'
print 'week2 assign 1'
print '####################'

#working on the same housing sales dataset
sales = graphlab.SFrame('kc_house_data.gl/')
train_data,test_data = sales.random_split(.8,seed=0) #split to train and test

example_features = ['sqft_living', 'bedrooms', 'bathrooms']
#example model is on train data
example_model = graphlab.linear_regression.create(train_data
                                                ,target = 'price'
                                                ,features = example_features
                                                ,validation_set = None)
example_weight_summary = example_model.get("coefficients")
print example_weight_summary

example_predictions = example_model.predict(train_data)
print example_predictions[0] # should be 271789.505878
def get_residual_sum_of_squares(model, data, outcome):
    outcome_pred = model.predict(data)
    residual = outcome - outcome_pred
    RSS=(residual**2).sum()
    return(RSS)  

rss_example_train = get_residual_sum_of_squares(example_model, test_data, test_data['price'])
print 'validity of get_residual_sum_of_squares: ' + str(rss_example_train)

##create some new features

from math import log

train_data['bedrooms_squared'] = train_data['bedrooms'].apply(lambda x: x**2)
test_data['bedrooms_squared'] = test_data['bedrooms'].apply(lambda x: x**2)

train_data['bed_bath_rooms'] = train_data['bedrooms']*train_data['bathrooms']
test_data['bed_bath_rooms'] = test_data['bedrooms']*test_data['bathrooms']

train_data['log_sqft_living'] = train_data['sqft_living'].apply(lambda x: log(x))
test_data['log_sqft_living'] = test_data['sqft_living'].apply(lambda x: log(x))

train_data['lat_plus_long'] = train_data['lat'] + train_data['long']
test_data['lat_plus_long'] = test_data['lat'] + test_data['long']

print 'quiz 1 mean of 4 new features on test data'
print test_data['bedrooms_squared'].mean()
print test_data['bed_bath_rooms'].mean()
print test_data['log_sqft_living'].mean()
print test_data['lat_plus_long'].mean()

### multiple models
model_1_features = ['sqft_living', 'bedrooms', 'bathrooms', 'lat', 'long']
model_2_features = model_1_features + ['bed_bath_rooms']
model_3_features = model_2_features + ['bedrooms_squared', 'log_sqft_living', 'lat_plus_long']

model_1 = graphlab.linear_regression.create(train_data,target = 'price',features = model_1_features,validation_set = None)
model_2 = graphlab.linear_regression.create(train_data,target = 'price',features = model_2_features,validation_set = None)
model_3 = graphlab.linear_regression.create(train_data,target = 'price',features = model_3_features,validation_set = None)

model_1_summary = model_1.get("coefficients")
model_2_summary = model_2.get("coefficients")
model_3_summary = model_3.get("coefficients")

# quiz What is the sign (positive or negative) for the coefficient/weight for 'bathrooms' in model 1 and in model 2
print model_1_summary
print model_2_summary
print model_3_summary

##comparing mutliple models

rss_train_model_1 = get_residual_sum_of_squares(model_1, train_data, train_data['price'])
rss_train_model_2 = get_residual_sum_of_squares(model_2, train_data, train_data['price'])
rss_train_model_3 = get_residual_sum_of_squares(model_3, train_data, train_data['price'])

#quiz rss on test is lowest for model 2 expected
print 'rss for 3 models on train_data'
print rss_train_model_1
print rss_train_model_2
print rss_train_model_3


rss_test_model_1 = get_residual_sum_of_squares(model_1, test_data, test_data['price'])
rss_test_model_2 = get_residual_sum_of_squares(model_2, test_data, test_data['price'])
rss_test_model_3 = get_residual_sum_of_squares(model_3, test_data, test_data['price'])

#quiz rss on test is lowest for model 2 expected
print 'rss for 3 models on test_data'
print rss_test_model_1
print rss_test_model_2
print rss_test_model_3

###################
print 'w2 asgn 2'
###################

import numpy as np

sales = graphlab.SFrame('kc_house_data.gl/')

def get_numpy_data(data_sframe, features, output):
    data_sframe['constant'] = 1 # this is how you add a constant column to an SFrame
    # add the column 'constant' to the front of the features list so that we can extract it along with the others:
    features = ['constant'] + features # this is how you combine two lists
    # select the columns of data_SFrame given by the features list into the SFrame features_sframe (now including constant):
    features_sframe = data_sframe[features]
    # the following line will convert the features_SFrame into a numpy matrix:
    feature_matrix = features_sframe.to_numpy()
    # assign the column of data_sframe associated with the output to the SArray output_sarray
    output_sarray = data_sframe[output]
    # the following will convert the SArray into a numpy array by first converting it to a list
    output_array = output_sarray.to_numpy()
    return(feature_matrix, output_array)

(example_features, example_output) = get_numpy_data(sales, ['sqft_living'], 'price') # the [] around 'sqft_living' makes it a list
print example_features[0,:] # this accesses the first row of the data the ':' indicates 'all columns'
print example_output[0] # and the corresponding output

my_weights = np.array([1., 1.]) # the example weights
my_features = example_features[0,] # we'll use the first data point
predicted_value = np.dot(my_features, my_weights)
print predicted_value # expected 1181

def predict_output(feature_matrix, weights):
    # assume feature_matrix is a numpy matrix containing the features as columns and weights is a corresponding numpy array
    # create the predictions vector by using np.dot()
    predictions = np.dot(feature_matrix,weights)
    return(predictions)

p= predict_output(example_features, np.array([1.0,1.0]))
print p

def feature_derivative(errors, feature):
    derivative = 2 * np.dot(errors,feature)
    return(derivative)

##testing
test_predictions = predict_output(example_features, my_weights) 
errors = test_predictions - example_output
feature = example_features[:,0]
#feature = example_features
derivative = feature_derivative(errors, feature)
print derivative
print -1.0 * np.sum(example_output)*2 #expect to be the same as derivative

#gradient descent
from math import sqrt

def regression_gradient_descent(feature_matrix, output, initial_weights, step_size, tolerance, debug):
    converged = False 
    weights = np.array(initial_weights) # make sure it's a numpy array
    niter = 0
    while not converged:
        # compute the predictions based on feature_matrix and weights using your predict_output() function
        predictions = predict_output(feature_matrix,weights)
        # compute the errors as predictions - output
        errors = predictions - output 
        gradient_sum_squares = 0 # initialize the gradient sum of squares
        # while we haven't reached the tolerance yet, update each feature's weight
        for i in range(len(weights)): # loop over each weight
            # Recall that feature_matrix[:, i] is the feature column associated with weights[i]
            # compute the derivative for weight[i]:            
            derivative_i = feature_derivative(errors, feature_matrix[:,i]) 
            # add the squared value of the derivative to the gradient sum of squares (for assessing convergence)
            gradient_sum_squares +=  derivative_i**2
            # subtract the step size times the derivative from the current weight
            weights[i] = weights[i] - step_size * derivative_i
        # compute the square-root of the gradient sum of squares to get the gradient matnigude:
        gradient_magnitude = sqrt(gradient_sum_squares)
        if gradient_magnitude < tolerance:
            print 'getting out on gradient < tolerance hit'
            converged = True
        niter +=  1
        if debug: 
            print 'cur inter: ' + str(niter)
            print 'cur derivative_i: ' + str(i) + ' ' + str(derivative_i)
            print 'cur gradient magn: ' + str(gradient_magnitude)
            print 'weights[0]: ' + str(weights[0]) + ' weights[1]: ' + str(weights[1])
        if niter > 1000:
            print 'getting out on max iterations hit'
            converged = True  
    return(weights)


train_data,test_data = sales.random_split(.8,seed=0)

simple_features = ['sqft_living']
my_output = 'price'
(simple_feature_matrix, output) = get_numpy_data(train_data, simple_features, my_output)
initial_weights = np.array([-47000., 1.])
step_size = 7e-12
tolerance = 2.5e7
debug = False

g_weights = regression_gradient_descent(simple_feature_matrix, output, initial_weights, step_size, tolerance,debug)
print g_weights

(test_simple_feature_matrix, test_output) = get_numpy_data(test_data, simple_features, my_output)


test_simple_predictions = predict_output(test_simple_feature_matrix,g_weights)
print 'quiz test_simple predict of 1 value ' + str(test_simple_predictions[0])

rss = np.sum( (test_simple_predictions - test_output)**2  )
print 'rss test_simple ' + str(rss)


model_features = ['sqft_living', 'sqft_living15'] # sqft_living15 is the average squarefeet for the nearest 15 neighbors. 
my_output = 'price'
(feature_matrix, output) = get_numpy_data(train_data, model_features, my_output)
initial_weights = np.array([-100000., 1., 1.])
step_size = 4e-12
tolerance = 1e9
debug = False

m_weights = regression_gradient_descent(feature_matrix, output, initial_weights, step_size, tolerance,debug)
print m_weights

(test_model_feature_matrix, test_output) = get_numpy_data(test_data, model_features, my_output)
test_model_predictions = predict_output(test_model_feature_matrix,m_weights)

print 'quiz test_model predict of 1st value ' + str(test_model_predictions[0])

rss_m = np.sum( (test_model_predictions - test_output)**2  )
print 'rss  test_model ' + str(rss_m)

###### week3
print '####################'
print 'week3 assign 1'
print '####################'
tmp = graphlab.SArray([1., 2., 3.])
tmp_cubed = tmp.apply(lambda x: x**3)
ex_sframe = graphlab.SFrame()
ex_sframe['power_1'] = tmp
ex_sframe['power_3'] = tmp_cubed

print ex_sframe

def polynomial_sframe(feature, degree):
    # assume that degree >= 1
    # initialize the SFrame:
    poly_sframe = graphlab.SFrame()
    # and set poly_sframe['power_1'] equal to the passed feature
    poly_sframe['power_1'] = feature
    # first check if degree > 1
    if degree > 1:
        # then loop over the remaining degrees:
        # range usually starts at 0 and stops at the endpoint-1. We want it to start at 2 and stop at degree
        for power in range(2, degree+1): 
            # first we'll give the column a name:
            name = 'power_' + str(power)
            poly_sframe[name] = feature.apply(lambda x: x**power) 
    return poly_sframe

print polynomial_sframe(tmp, 5)

sales = graphlab.SFrame('kc_house_data.gl/')
sales = sales.sort(['sqft_living', 'price']) ## sorting

poly1_data = polynomial_sframe(sales['sqft_living'], 1)
poly1_data['price'] = sales['price']

model1 = graphlab.linear_regression.create(poly1_data, target = 'price',features = ['power_1'], validation_set = None)
print model1.get("coefficients")


import matplotlib.pyplot as plt
#%matplotlib inline

### works in the notebook
#plt.plot(poly1_data['power_1'],poly1_data['price'],'.',
#        poly1_data['power_1'], model1.predict(poly1_data),'-')


poly2_data = polynomial_sframe(sales['sqft_living'], 2)
my_features = poly2_data.column_names() # get the name of the features
poly2_data['price'] = sales['price'] # add price to the data since it's the target
model2 = graphlab.linear_regression.create(poly2_data, target = 'price',features = my_features, validation_set = None)
print model2.get("coefficients")

poly3_data = polynomial_sframe(sales['sqft_living'], 3)
my_features = poly3_data.column_names() # get the name of the features
poly3_data['price'] = sales['price'] # add price to the data since it's the target
model3 = graphlab.linear_regression.create(poly3_data, target = 'price',features = my_features, validation_set = None)
print model3.get("coefficients")

# poly15_data = polynomial_sframe(sales['sqft_living'], 15)
# my_features = poly15_data.column_names() # get the name of the features
# poly15_data['price'] = sales['price'] # add price to the data since it's the target
# model15 = graphlab.linear_regression.create(poly15_data, target = 'price',features = my_features, validation_set = None)

### splitting data in 4 equal sets
dh1,dh2 = sales.random_split(.5,seed=0)
set_1,set_2 = dh1.random_split(.5,seed=0)
set_3,set_4 = dh2.random_split(.5,seed=0)
## 4 15-polynomials models on 4 different data sets
poly15_data_1 = polynomial_sframe(set_1['sqft_living'], 15)
my_features = poly15_data_1.column_names()
poly15_data_1['price'] = set_1['price']
model15_s_1 = graphlab.linear_regression.create(poly15_data_1, target = 'price',features = my_features, validation_set = None)
model15_s_1.get("coefficients").print_rows(num_rows=16)

poly15_data_2 = polynomial_sframe(set_2['sqft_living'], 15)
my_features = poly15_data_2.column_names()
poly15_data_2['price'] = set_2['price']
model15_s_2 = graphlab.linear_regression.create(poly15_data_2, target = 'price',features = my_features, validation_set = None)
# plt.plot(poly15_data_2['power_1'],poly15_data_2['price'],'.',
#         poly15_data_2['power_1'], model15_s_2.predict(poly15_data_2),'-')
model15_s_2.get("coefficients").print_rows(num_rows=16)


poly15_data_3 = polynomial_sframe(set_3['sqft_living'], 15)
my_features = poly15_data_3.column_names()
poly15_data_3['price'] = set_3['price']
model15_s_3 = graphlab.linear_regression.create(poly15_data_3, target = 'price',features = my_features, validation_set = None)
# plt.plot(poly15_data_3['power_1'],poly15_data_3['price'],'.',
#         poly15_data_3['power_1'], model15_s_3.predict(poly15_data_3),'-')
model15_s_3.get("coefficients").print_rows(num_rows=16)

poly15_data_4 = polynomial_sframe(set_4['sqft_living'], 15)
my_features = poly15_data_4.column_names()
poly15_data_4['price'] = set_4['price']
model15_s_4 = graphlab.linear_regression.create(poly15_data_4, target = 'price',features = my_features, validation_set = None)
# plt.plot(poly15_data_4['power_1'],poly15_data_4['price'],'.',
#         poly15_data_4['power_1'], model15_s_4.predict(poly15_data_4),'-')
model15_s_4.get("coefficients").print_rows(num_rows=16)

##selecting a polynomial degree
training_and_validation,testing = sales.random_split(.9,seed=1)
training,validation = training_and_validation.random_split(.5,seed=1)

##loop over 15 models with increasing  number of degrees
maxdegree=15
rsses=np.empty(maxdegree)
models=[]
for degree in range(1, maxdegree+1): 
    print 'polynomial degree: ' + str(degree)  
    cdata_train =  polynomial_sframe( training['sqft_living'],degree)
    cfeatures = cdata_train.column_names()
    cdata_train['price'] = training['price']

    cmodel = graphlab.linear_regression.create(cdata_train, target = 'price',features = cfeatures, validation_set = None, verbose=False)

    cdata_valid =  polynomial_sframe( validation['sqft_living'],degree)
    cdata_valid['price'] = validation['price']

    rss_vld = ((cmodel.predict(cdata_valid) - cdata_valid['price'])**2 ).sum()
    rsses[degree-1]=rss_vld
    models=models+[ cmodel ]
print 'current rsses on validation: ' + str(rsses)



data_test =  polynomial_sframe( testing['sqft_living'],6)
features =  data_test.column_names()
data_test['price'] = testing['price']
rss_lambda = ((models[5].predict(data_test) - data_test['price'])**2 ).sum()
print 'rss_lambda_fixed: ' + str(rss_lambda)


#end