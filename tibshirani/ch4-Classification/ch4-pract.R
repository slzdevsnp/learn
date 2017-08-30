#rm(list=ls());setwd("c:/users/zimine/Dropbox/cs/bigdata/lagunita/tibshirani/ch4-Classification/");source("ch4-pract.R")
#rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch4-Classification/");source("ch4-pract.R")

##### ch4 lab

library(ISLR)
## sp500 5 lags returns dataset
print(names(Smarket))
print(dim(Smarket))
print(str(Smarket))
print(summary(Smarket))

##correlation between all numeric columsn
print(cor(Smarket[,-9]))
#visualization of variables dependencies
##pairs(Smarket, cex=0.1)


##logistic regression model. 
# we will fit a logistic regression model to predict direction using lag1 through lag5
#glm generalized linear model
attach(Smarket)
glm.fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,data=Smarket,family=binomial)

print(summary(glm.fit))

#how to print p-values of coefficients
print(summary(glm.fit)$coef[,4])

#predict direction using the training data  to store probabilities.
glm.probs <- predict(glm.fit, type="response")

#convert probabilities into a binar reponse  ? P> 0.5 : class 1 ; class b
 glm.pred<-rep("Down",length(glm.probs))
 glm.pred[glm.probs > .5] <- "Up"

print(glm.pred[1:10])

print( 
table(glm.pred, Direction)
)
