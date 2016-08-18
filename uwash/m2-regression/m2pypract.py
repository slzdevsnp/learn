#import os ; os.chdir('c:/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/m2-regression') ; execfile('m2pypract.py')

#import os ; os.chdir('/Users/zimine/Dropbox/cs/bigdata/coursera/uwash/m2-regression') ; execfile('m2pypract.py')


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

#end