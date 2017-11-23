##ch6-exercises-applied


# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch6-ModelSelection/");source("ch6-ex-applied.R")


require(leaps)


### applied exercies
print("ex 8")

set.seed(1)
##a)
n<-100
x<-rnorm(n)
epsilon <-rnorm(n) 
##b)

beta0<- 3
beta1<- 2
beta2<- -3
beta3<- 0.3

y<-beta0 + beta1*x + beta2*x^2 + beta3*x^3 + epsilon

#c)
dataset <- data.frame(y,x,x^2,x^3,x^4,x^5,x^6,x^7,x^8,x^9,x^10)
colnames(dataset) <- c("response", "x1", "x2", "x3", "x4", "x5"
					  ,"x6", "x7", "x8", "x9", "x10")
p_feats<-10
regfit.full<-regsubsets(response~., data=dataset, nvmax=p_feats)
reg.summary<-summary(regfit.full)
print(reg.summary)

par(mfrow=c(2,2))
plot(reg.summary$rss ,xlab="best subset #params",ylab="RSS",type="l")

plot(reg.summary$adjr2, xlab="best subset #params",ylab="Adjusted RSq", type="l")
ar2_idx<-which.max(reg.summary$adjr2)
points(ar2_idx, reg.summary$adjr2[ar2_idx],col="red", cex=1, pch=20)

plot(reg.summary$cp, xlab="best subset #params",ylab="Cp", type="l")
cp_idx<-which.min(reg.summary$cp)
points(cp_idx, reg.summary$cp[cp_idx],col="red", cex=1, pch=20)

plot(reg.summary$bic, xlab="best subset #params",ylab="BIC", type="l")
bic_idx<-which.min(reg.summary$bic)
points(bic_idx, reg.summary$bic[bic_idx],col="red", cex=1, pch=20)

print("all measures are at minimum for a model with 3 variables")

#d) forward selection

regfit.fwd<-regsubsets(response~., data=dataset, nvmax=p_feats, method="forward")
reg.summary<-summary(regfit.fwd)

dev.new()
par(mfrow=c(2,2))
plot(reg.summary$rss ,xlab="forward select #params",ylab="RSS",type="l")

plot(reg.summary$adjr2, xlab="forward select #params",ylab="Adjusted RSq", type="l")
ar2_idx<-which.max(reg.summary$adjr2)
points(ar2_idx, reg.summary$adjr2[ar2_idx],col="red", cex=1, pch=20)

plot(reg.summary$cp, xlab="forward select #params",ylab="Cp", type="l")
cp_idx<-which.min(reg.summary$cp)
points(cp_idx, reg.summary$cp[cp_idx],col="red", cex=1, pch=20)

plot(reg.summary$bic, xlab="forward select #params",ylab="BIC", type="l")
bic_idx<-which.min(reg.summary$bic)
points(bic_idx, reg.summary$bic[bic_idx],col="red", cex=1, pch=20)

#backard selection

regfit.bwd<-regsubsets(response~., data=dataset, nvmax=p_feats, method="backward")
reg.summary<-summary(regfit.bwd)

dev.new()
par(mfrow=c(2,2))
plot(reg.summary$rss ,xlab="backard select #params",ylab="RSS",type="l")

plot(reg.summary$adjr2, xlab="backward select #params",ylab="Adjusted RSq", type="l")
ar2_idx<-which.max(reg.summary$adjr2)
points(ar2_idx, reg.summary$adjr2[ar2_idx],col="red", cex=1, pch=20)

plot(reg.summary$cp, xlab="backward select #params",ylab="Cp", type="l")
cp_idx<-which.min(reg.summary$cp)
points(cp_idx, reg.summary$cp[cp_idx],col="red", cex=1, pch=20)

plot(reg.summary$bic, xlab="backward select #params",ylab="BIC", type="l")
bic_idx<-which.min(reg.summary$bic)
points(bic_idx, reg.summary$bic[bic_idx],col="red", cex=1, pch=20)


print("for backward and forward selection results are identical as for best subset selection")

##see coefs
print(coefficients(regfit.full , id=3))
print(coefficients(regfit.fwd , id=3))
print(coefficients(regfit.bwd , id=3))

##e) lasso)
require(glmnet)

xv <- model.matrix(response~., data=dataset)[,-1]
yv <- dataset$response
set.seed(1)
grid <- 10^seq(10,-2,length=100)
lasso.mod <- glmnet(xv, yv, alpha=1, lambda=grid)



