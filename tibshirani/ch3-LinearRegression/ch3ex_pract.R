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
#ii.  the rse = 4.906 the mean value of responnse is 23.45. so  we have a percentage error 4.906/23.45 = 20 %
# R^2 = 0.6  So the model does not fit the data very closely

#ex9
Auto<-read.csv("../data/Auto.csv", header=T, na.strings="?")
summary(Auto$horsepower)


cor(Auto[,1:8], use="complete.obs")

lmfit3<-lm(mpg~.-name+cylinders:displacement, data=Auto)

#9.e
# cylinders:displacement
# cylincders:horsepower
# cylinders:year

##--cylinders:weight
##--cylinders:origin 


##-displacement:horsepower
##- displacement:weight

#9.f

##displacement helps  log(x) and x^2 term 

#horsepower :  log   sqrt  

#weight : log , x^2

 #ex 10 

require(ISLR)
data(Carseats)
# str(Carseats)

## pairs on Sales, Price, Urban, US
pairs(Carseats[,c(1,6,10,11)], cex=0.1)
lmfit101<-lm(Sales~Price+Urban+US, data=Carseats)
print( summary(lmfit101) )

#ex 11

set.seed(1)
x=rnorm(100)
y<-2*x+rnorm(100)

lmfit111<-lm(y~x-1)
summary(lmfit111)


##ex12 
set.seed(1)
x=rnorm(100)
y<-2*x+runif(100)
print(summary(lm(y~x-1)))
print(summary(lm(x~y-1)))


#browser()
#ex13
set.seed(1)
x<-rnorm(100, mean=0, sd=1) #default values
#(b)
eps<-rnorm(100, mean=0, sd=0.25) #residuals with smaller variance
#c)
y<- -1+0.5*x + eps
#(d)
plot(y~x)

#e)
lmfit131<-lm(y~x)
print(summary(lmfit131))
#(f)
abline(lmfit131, col=2)
abline(-1, 0.5, col=3)
legend(-1, legend=c("model fit", "pop. regression"),col=2:3,lwd=3 )
#(g)
lmfit132<-lm(y~x+I(x^2))
print(summary(lmfit132)) #lower  F-statistic

plot(y~x)
abline(lmfit131, col=2)
points(x,predict(lmfit132, data.frame(x)) ,col=4, cex=0.2)
legend(-1, legend=c("linear model fit", "quadratic model fit"),col=c(2,4),lwd=3 )


##ex 14

set.seed(1)
x1<-runif(100)
x2<-0.5*x1 + rnorm(100)/10
y<-2+2*x1 +0.3*x2+rnorm(100)

#14.c
lmfit141<-lm(y~x1+x2)
print(summary(lmfit141))

# 14.d
lmfit142<-lm(y~x1)
print(summary(lmfit142))
## ans: due to low p-value for x1 coef we can reject null hypo H_0 : \beta_1 = 0

# 14.e
lmfit143<-lm(y~x2)
print(summary(lmfit143))
## ans: due to low p-value for x1 coef we can reject null hypo H_0 : \beta_2 = 0

# 14.g
x1 <- c(x1, 0.1)
x2 <- c(x2, 0.8) #this is an outlier seen on the plot
y  <- c(y, 6) 

plot(x1,x2)

par(mfrow=c(3,2))
plot(lmfit141, cex=0.3)

plot(predict(lmfit141), rstudent(lmfit141)) # for outliers  (rstudent studentized resitulas shoud stay in [-3;3] )

lmfit141<-lm(y~x1+x2) #redowing
print(summary(lmfit141))

dev.new()

par(mfrow=c(3,2))
plot(lmfit141, cex=0.3)
plot(predict(lmfit141), rstudent(lmfit141))

# ans. model (c) slighly larger F-statistic and slightly larger R^2
#  2. according to studentized residual chart the new point is not  and outlier  
#  and it is a highly leverated point as its leverage statistics greatly exceeds  vlaue (p+1)/n = 3/101 = 0.03




### end
#dev.off()

