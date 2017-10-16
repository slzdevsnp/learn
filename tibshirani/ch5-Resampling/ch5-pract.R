##ch5-prat

# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch5-Resampling/");source("ch5-pract.R")

##lab

library(ISLR)
set.seed(1)

#make a sample of integers between 1,392 of size  196 ,half of 392 obs
train<-sample(392,196)
print(dim(Auto))

#work on Auto dataset
#linear regression using a randomly rearranged auto dataset 
lm.fit<-lm(mpg~horsepower,data=Auto,subset=train)

#use predict() to estimate response on validation set (model was trained on the whole set)
attach(Auto)
#see CV error on vaidation set
print(paste("estimated MSE on lm:",mean( (mpg-predict(lm.fit,Auto))[-train]^2  )))


#do the estimation of the same MSE on poly models
lm.fit2<-lm(mpg~poly(horsepower,2),data=Auto,subset=train)
print(paste("estimated MSE on lm poly 2:",mean( (mpg-predict(lm.fit2,Auto))[-train]^2  )))

lm.fit3<-lm(mpg~poly(horsepower,3),data=Auto,subset=train)
print(paste("estimated MSE on lm poly 3:",mean( (mpg-predict(lm.fit3,Auto))[-train]^2  )))

lm.fit4<-lm(mpg~poly(horsepower,4),data=Auto,subset=train)
print(paste("estimated MSE on lm poly 4:",mean( (mpg-predict(lm.fit4,Auto))[-train]^2  )))

##lets see how choosing another trainig set afects  MSE results
set.seed(2)
train<-sample(392,196) #resample
lm.fit<-lm(mpg~horsepower,data=Auto,subset=train)
print(paste("estimated MSE on lm:",mean( (mpg-predict(lm.fit,Auto))[-train]^2  )))
lm.fit2<-lm(mpg~poly(horsepower,2),data=Auto,subset=train)
print(paste("estimated MSE on lm poly 2:",mean( (mpg-predict(lm.fit2,Auto))[-train]^2  )))
lm.fit3<-lm(mpg~poly(horsepower,3),data=Auto,subset=train)
print(paste("estimated MSE on lm poly 3:",mean( (mpg-predict(lm.fit3,Auto))[-train]^2  )))
lm.fit4<-lm(mpg~poly(horsepower,4),data=Auto,subset=train)
print(paste("estimated MSE on lm poly 4:",mean( (mpg-predict(lm.fit4,Auto))[-train]^2  )))

########## loocv ################
print('')
print('###########Leave-One-Out Cross-Validation (LOOCV)######')
glm.fit<-glm(mpg~horsepower,data=Auto) #no params in glm  == linear regression is done
print(coef(glm.fit))

require(boot)
glm.fit<-glm(mpg~horsepower,data=Auto)
cv.err<-cv.glm(Auto,glm.fit)
print("cv error on lm:")
print(cv.err$delta)


#redo loocv for 5 degrees of polynomial 
# cv.error<-rep(0,3)
# for (i in 1:3){
# 	print(paste("loocv for degree:",i,".."))
# 	glm.fit<-glm(mpg~poly(horsepower,i),data=Auto)
# 	cv.error[i] <- cv.glm(Auto, glm.fit)$delta[1]
# }
# print("loocv for poly of 5 degrees")
# print(cv.error)

## k-fold validation
set.seed(17)
cv.error10<-rep(0,10)
for (i in 1:10){
	print(paste("k-fold for degree:",i,".."))
	glm.fit<-glm(mpg~poly(horsepower,i),data=Auto)
	cv.error10[i] <- cv.glm(Auto, glm.fit,K=10)$delta[1] #same cv.glm func is used with K param
}
print("k-fold for poly of 10 degrees k = 10")
print(cv.error10)


## bootstrap
alpha.fn<-function(data,index){
	x<-data$X[index]
	y<-data$Y[index]
    vx<-var(x)
    vy<-var(y)
    cxy<-cov(x,y)
    return( (vx-cxy)/(vx+vy-2*cxy) )
}

print(alpha.fn(Portfolio,1:100))


set.seed(1)
#alpha from a sampled dataset
print(alpha.fn(Portfolio,sample(100,100,replace=T)))
#calling  a bootstrap 1000 times
print(boot(Portfolio, alpha.fn, R=1000))

#Estimate accuracy of the linear regression model

boot.fn<-function(data,index){
	return (coef(lm(mpg~horsepower,data=data,subset=index)))
}

print(boot.fn(Auto,1:392))

set.seed(1)
print("## applying bootstrap to estimate lm coefficients")
print( boot(Auto,boot.fn,1000))

#compare this with a standard lm call
lm.fit<-lm(mpg~horsepower,data=Auto)
print(summary(lm.fit)$coef)
