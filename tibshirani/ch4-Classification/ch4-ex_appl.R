# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch4-Classification/");source("ch4-ex_appl.R")

##### ch4  applied exercices

library(ISLR)

str(Weekly)



##10.b) 
#logistic regression
glm.fit <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume
	          ,data=Weekly, family=binomial)
print(summary(glm.fit))


#10.c)  compute confusion matrix

logr.proba <- predict(glm.fit, type="response")
logr.pred <- rep("Down", length(logr.proba))
logr.pred[logr.proba > .5] <- "Up"

logr.cfm <- table(logr.pred, Weekly$Direction)
print(logr.cfm)

print(paste("log reg model correct rate:",mean(logr.pred == Weekly$Direction)))
print(paste("log reg model error rate:", 1 - mean(logr.pred == Weekly$Direction)))

#10.d) log reg over training (1990-2008) and test >= 2009
# check predictions over test data

#split to training and test  sets
train_idx <- Weekly$Year < 2009
Weekly_train <- Weekly[train_idx,]
Weekly_test  <- Weekly[!train_idx,]
print(dim(Weekly_train))
print(dim(Weekly_test))

glm.fit_tr <- glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume
	          ,data=Weekly_train, family=binomial)
print(summary(glm.fit_tr))

logr.proba_ts <- predict(glm.fit_tr, Weekly_test, type="response")
logr.pred_ts <- rep("Down", length(logr.proba_ts))
logr.pred_ts[logr.proba_ts > .5] <- "Up"
print(length(logr.pred_ts))

logr.cfm_ts <- table(logr.pred_ts, Weekly_test$Direction)
print(logr.cfm_ts)
print(paste("log reg same model correct rate on test:",mean(logr.pred_ts == Weekly_test$Direction)))
print(paste("log reg same model error rate on test:", 1 - mean(logr.pred_ts == Weekly_test$Direction)))

## so using he same logistic regresson on all predictor
## we have a worsenning of error rate on test 

#log reg using just Lag2 as the only predictor
glm.fit_tr2 <- glm(Direction~Lag2,data=Weekly_train, family=binomial)
print(summary(glm.fit_tr2))

logr.proba_ts <- predict(glm.fit_tr2, Weekly_test, type="response")
logr.pred_ts <- rep("Down", length(logr.proba_ts))
logr.pred_ts[logr.proba_ts > .5] <- "Up"


logr.cfm_ts <- table(logr.pred_ts, Weekly_test$Direction)
print(logr.cfm_ts)
print(paste("log reg Lag2 model correct rate on test:",mean(logr.pred_ts == Weekly_test$Direction)))
print(paste("log reg Lag2 model error rate on test:", 1 - mean(logr.pred_ts == Weekly_test$Direction)))



##10.e)  repeat d) using LDA
require(MASS)
lda.fit <- lda(Direction~Lag2, data=Weekly, subset=train_idx)
lda.pred <- predict(lda.fit, Weekly_test)
lda.class <- lda.pred$class 

lda.cfm <- table(lda.class, Weekly_test$Direction)
print(lda.cfm)
print(paste("LDA Lag2 model correct rate on test:",mean(lda.class == Weekly_test$Direction)))
print(paste("LDA Lag2 model error rate on test:", 1 - mean(lda.class == Weekly_test$Direction)))

##10.f  repead d) using QDA
qda.fit <- qda(Direction~Lag2, data=Weekly, subset=train_idx)
qda.pred <- predict(qda.fit, Weekly_test)
qda.class <-qda.pred$class 
qda.cfm <- table(qda.class, Weekly_test$Direction)
print(qda.cfm)
print(paste("QDA Lag2 model correct rate on test:",mean(qda.class == Weekly_test$Direction)))
print(paste("QDA Lag2 model error rate on test:", 1 - mean(qda.class == Weekly_test$Direction)))


##10.g  repeat d) knn with k=1
library(class)

train.X <- cbind(Weekly_train$Lag2)
test.X <- cbind(Weekly_test$Lag2)


getKnnPrediction <- function(train, test, train_y, test_y, k=1){ 
	set.seed (1)
	knn.pred <- knn(train,test,train_y, k=k)
	cfm_knn <- table(knn.pred, test_y)
	print(cfm_knn) 
    print(paste("knn model correct rate on test for k =",k,":",
    	mean(knn.pred == test_y)))
    print(paste("knn model error rate on test for k =",k,":",
    	1-mean(knn.pred == test_y)))

}

getKnnPrediction(train=train.X, test=test.X,
	             train_y=Weekly_train$Direction, test_y=Weekly_test$Direction,k=1)


##10.i 
##combine lag1 and lag2 into averaged lag 
Weekly_t <- Weekly 
Weekly_t$Lag12 <- 0.5*(Weekly_t$Lag1+Weekly_t$Lag2)
Weekly_t_train <- Weekly_t[train_idx,]
Weekly_t_test  <- Weekly_t[!train_idx,]

lda.fit <- lda(Direction~Lag12, data=Weekly_t, subset=train_idx)
lda.pred <- predict(lda.fit, Weekly_t_test)
lda.class <- lda.pred$class 

lda.cfm <- table(lda.class, Weekly_t_test$Direction)
print(lda.cfm)
print(paste("LDA Lag12 model correct rate on test:",mean(lda.class == Weekly_t_test$Direction)))
print(paste("LDA Lag12 model error rate on test:", 1 - mean(lda.class == Weekly_t_test$Direction)))


#check Log Reg with Lag1:lAg2   i.e. with inrecaction term

glm.fit_tr2 <- glm(Direction~Lag2:Lag1,data=Weekly_train, family=binomial)

logr.proba_ts <- predict(glm.fit_tr2, Weekly_test, type="response")
logr.pred_ts <- rep("Down", length(logr.proba_ts))
logr.pred_ts[logr.proba_ts > .5] <- "Up"


logr.cfm_ts <- table(logr.pred_ts, Weekly_test$Direction)
print(logr.cfm_ts)
print(paste("log reg Lag2:Lag1 model correct rate on test:",mean(logr.pred_ts == Weekly_test$Direction)))
print(paste("log reg Lag2:Lag1 model error rate on test:", 1 - mean(logr.pred_ts == Weekly_test$Direction)))

