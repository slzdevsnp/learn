##ch5-pract


# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch6-ModelSelection/");source("ch6-lecture.R")

# 
# ..
#### Model selection using a validation set

require(ISLR)
require(leaps)

data(Hitters)
Hitters <- na.omit(Hitters)


set.seed(1)
nrows <- dim(Hitters)[1] #263
sample_size <- floor(2/3 * nrows) + 5  # training sample of size 180
train<-sample(seq(nrows),sample_size,replace=FALSE)
regfit.fwd <- regsubsets(Salary~. ,data=Hitters[train,]
						,nvmax=19,method="forward")


val.errors<-rep(NA,19) # 19 is thte max numb of predictors in the Hitters dataset
x.test <- model.matrix(Salary~. , data=Hitters[-train,]) #

for(i in 1:19){
   coefi <- coef(regfit.fwd,id=i)
   pred  <- x.test[,names(coefi)]%*%coefi #varieables * model coefficients
   val.errors[i] <- mean((Hitters$Salary[-train]-pred)^2)
}
plot(sqrt(val.errors), ylab="Root MSE", ylim=c(300,400), pch=19,type="b")
points(sqrt(regfit.fwd$rss[-1]/sample_size), col="blue", pch=19,type="b")
legend("topright", legend=c("Training", "Validation"), col=c("blue","black"), pch=19)

#lets rewrite the code above in the function
predict.regsubsets<-function(object,newdata,id,...){
	form<-as.formula(object$cal[[2]])
	mat<-model.matrix(form,newdata)
	coefi<-coef(object,id=id)
	mat[,names(coefi)]%*%coefi
}




