#rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch3-LinearRegression/");source("ch3ex_pract.R")


#ch3 ex applied helper code

#ex 8
require(ISLR)
data(Auto)
str(Auto)
#8.a
lmfit1<-lm(mpg~horsepower,data=Auto)
print(summary(lmfit1))
plot(mpg~horsepower,data=Auto, cex=0.3)
abline(lmfit1, col=2)
#i. we have a low p-value coef for horsepower variable  i.e. a relation between response and predictor exists
#ii. 
