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

## lets write the function

predict.regsubsets<-function(object,newdata,id,...){
    form<-as.formula(object$call[[2]])
    mat<-model.matrix(form,newdata)
    coefi<-coef(object,id=id)
    mat[,names(coefi)]%*%coefi
}

#lets use this function 
regfit.best<-regsubsets(Salary~. ,data=Hitters, nvmax =p_features)
print("coefs of best model of k=10 after a fit on all data")
print(coef(regfit.best ,ve_min))

##We now try to choose among the models of different sizes using cross- validation.
#for k-10 folds
k<-10
set.seed(1)
folds<-sample(1:k, nrow(Hitters), replace=TRUE)
cv.errors <- matrix(NA,k,p_features, dimnames=list(NULL,paste(1:19)))
#lets write a loop that performance cross-validation
#looping on folds
for(j in 1:k ){

	best.fit <- regsubsets(Salary~.,data=Hitters[folds!=j,] ,nvmax=p_features)
   	for(i in 1:19){
   		pred<-predict.regsubsets(best.fit, Hitters[folds==j,], id=i)
   		cv.errors[j,i]<-mean( (Hitters$Salary[folds==j]-pred)^2)
   }	
}

mean.cv.errors <- apply(cv.errors, 2, mean)
print(paste("mean cv error:", paste(mean.cv.errors, collapse=",")))
par(mfrow=c(1,1))
plot(mean.cv.errors, type='b', main="cross-validation curve for best subset selection")

min_cve_idx <- which.min(as.numeric(mean.cv.errors))
points(min_cve_idx, mean.cv.errors[min_cve_idx],col="red", cex=2, pch=20)


### lab 2 Ridge and Lasso 
library(glmnet)
x <- model.matrix(Salary~. ,data=Hitters)[,-1]
#x <- model.matrix(Salary~.-1 ,data=Hitters)
y <- Hitters$Salary 

#ridge regression
grid <- 10^seq(10,-2,length=100) # array of 100 values from 10^10 to 10^-2 for lambda
ridge.mod <- glmnet(x,y, alpha=0, lambda=grid) # alpha = 0  is ridge
print("model coeff for the lambda in the middle of the grid")
print(coef(ridge.mod)[,50])

print("to obtain ridge regression coefficien for lambda =50")
print(predict(ridge.mod, s=50,type="coefficients")[1:20,])

##split data
set.seed(1)
#split in half
train <- sample(1:nrow(x), nrow(x)/2)
test <- !train 
y.test <- y[test]


