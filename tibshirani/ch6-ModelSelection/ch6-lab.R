##ch6-lab


# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch6-ModelSelection/");source("ch6-lab.R")


require(ISLR)
require(leaps)

data(Hitters)
names(Hitters)

##clean data
sum(is.na(Hitters))
Hitters <- na.omit(Hitters)
sum(is.na(Hitters))


## chose model using validation set and cross-validation

## 1.validation set approach 

set.seed(1) 
train <- sample( c(TRUE,FALSE), nrow(Hitters), rep=TRUE)
test <- !train
#sum(train)

p_features<- dim(Hitters)[2] -1

#fit on training set
regfit.best<-regsubsets(Salary~.,data=Hitters[train,], nvmax =p_features)

#compute validation set error

test.mat<-model.matrix(Salary~. ,data=Hitters[test,])

val.errors <- rep(NA,p_features)

for (i in 1:p_features){
	coefi <- coef(regfit.best,id=i) #best model of size k=i
    pred  <- test.mat[,names(coefi)]%*%coefi
    val.errors[i] <- mean( (Hitters$Salary[test]-pred)^2 )
}
plot(val.errors, ylab="test error", xlab="number of parametrs", type="l")
ve_min <- which.min(val.errors)
points(ve_min,val.errors[ve_min],col="red", cex=2, pch=20)

print(paste("test err min:",ve_min))
print(coef(regfit.best,id=ve_min))