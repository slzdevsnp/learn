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




#end