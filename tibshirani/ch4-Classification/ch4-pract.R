#rm(list=ls());setwd("c:/users/zimine/Dropbox/cs/bigdata/lagunita/tibshirani/ch4-Classification/");source("ch4-pract.R")
# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch4-Classification/");source("ch4-pract.R")

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

cfu_m <- table(glm.pred,Direction)
print(cfu_m)

#model is correct  this percentage
(cfu_m[1,1]+cfu_m[2,2] )/ sum(cfu_m)
#this also equals
print(paste("percengate that model is correct:",mean(glm.pred == Direction)))
print(paste("training error rate:", 1 - mean(glm.pred == Direction)))

#lets obtain a more realistic error rate on a subset of data used as training set 
#and check it on a test dataset
train_idx <- Smarket$Year<2005
train<- Smarket[train_idx,]
Smarket.2005<-Smarket[!train_idx,]
test<-Smarket.2005
print(dim(train))
print(dim(test))

#model on a train dataset
glm.fit_tr <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume
	             ,data=train,family=binomial)
glm.probs_tst <- predict(glm.fit_tr, test, type="response")

glm.pred_tst<-rep("Down",length(glm.probs_tst))
glm.pred_tst[glm.probs_tst > .5] <- "Up"

cfu_m_tst <- table(glm.pred_tst,test$Direction)
print(cfu_m_tst)

print(paste("percengate model is correct on test data:",mean(glm.pred_tst == test$Direction)))
print(paste("training error rate on test data:", 1 - mean(glm.pred_tst == test$Direction)))


#lets refit the model using only 2 predictors with lowest  p-value

glm.fit_tr <- glm(Direction~Lag1+Lag2
	             ,data=train,family=binomial)
glm.probs_tst <- predict(glm.fit_tr, test, type="response")

glm.pred_tst<-rep("Down",length(glm.probs_tst))
glm.pred_tst[glm.probs_tst > .5] <- "Up"

cfu_m_tst <- table(glm.pred_tst,test$Direction)
print(cfu_m_tst)

print(paste("percentage, model is correct on test data:",mean(glm.pred_tst == test$Direction)))
print(paste("training error rate on test data:", 1 - mean(glm.pred_tst == test$Direction)))

#LDA
require(MASS)

lda.fit <- lda(Direction~Lag1+Lag2,data = Smarket, subset = train_idx)
print(lda.fit)

lda.pred <- predict(lda.fit, Smarket.2005) # on test data 
lda.class <- lda.pred$class 
cfu_m_lda <- table(lda.class , test$Direction)
print(cfu_m_lda)
print(paste("lda model is correct on stet data: ", mean(lda.class == test$Direction)))

##QDA
qda.fit <- qda(Direction~Lag1+Lag2,data = Smarket, subset = train_idx)
print(qda.fit)

qda.pred <- predict(qda.fit, Smarket.2005) # on test data 
qda.pred.class <- qda.pred$class 
cfu_qda_tst <- table (qda.pred.class, Smarket.2005$Direction)
print(cfu_qda_tst)
print(paste("qda model is correct on stet data: ", mean(qda.pred.class == Smarket.2005$Direction)))

