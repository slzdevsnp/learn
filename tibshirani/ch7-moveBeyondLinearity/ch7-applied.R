##ch7-applied


# setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch7-moveBeyondLinearity/");source("ch7-applied.R")

pprint<-function(msg, bc="*"){
  mlen <- nchar(msg)
  bord_str <- paste(rep(bc, mlen+4),collapse="")
  msg_bord_str <- paste(rep(bc, 1),collapse="")
  print(bord_str)
  print(paste( msg_bord_str,msg, msg_bord_str), sep="")
  print(bord_str)
}

pprint("exercise 9")

require(MASS)
attach(Boston)

#a)
fit.1 <- lm(nox~poly(dis,3), data=Boston)
dis.grid <- seq(range(dis)[1], range(dis)[2], by=0.05)
preds <- predict(fit.1, newdata=list(dis=dis.grid), se=T )
plot(nox~dis,data=Boston,cex=0.6,col="gray")
lines(dis.grid, preds$fit, lwd=2, col="red")

#b)
rss<-rep(NA,10)
fits <- list()
preds <- list()
plot(nox~dis,data=Boston,cex=0.6,col="gray")
for (d in 1:10){
  fits[[d]] <- lm(nox~poly(dis,d), data=Boston)
  rss[d] <- deviance(fits[[d]])
  preds[[d]] <- predict(fits[[d]], newdata=list(dis=dis.grid))
  lines(dis.grid, preds[[d]], lwd=1, col=d)
}
print(rss)

#c)
require(boot)

set.seed(1)
cv.errs <- rep(NA,10)
for (d in 1:10){
  fit <- glm(nox~poly(dis,d), data=Boston)
  cv.errs[d] <- cv.glm(Boston, fit, K=10)$delta[2]
}
print( which.min(cv.errs) )
plot(cv.errs, type="l")

#d)
require(splines)
fit <- lm(nox~bs(dis,df=4, knots=c(3,6,8)), data=Boston)
pred <- predict(fit, newdata=list(dis=dis.grid), se=T )
plot(nox~dis,data=Boston,cex=0.6,col="gray")
lines(dis.grid,pred$fit,lwd=2, col="blue")
lines(dis.grid,pred$fit+2*pred$se ,lty="dashed")
lines(dis.grid,pred$fit-2*pred$se ,lty="dashed")


#e)
cv.errs <- rep(NA,14)
rss <- rep(NA,14)
for (df in 3:14){
  fit <- glm(nox~bs(dis,df=df), data=Boston)
  cv.errs[df] <- cv.glm(Boston, fit, K=10)$delta[2]
  rss[df] <- sum(fit$residuals^2)
}
print( rss[-c(1,2)] )

#d)
cv.errs <- rep(NA,14)
for (df in 3:14){
  fit <- glm(nox~bs(dis,df=df), data=Boston)
  cv.errs[df] <- cv.glm(Boston, fit, K=10)$delta[2]
}
print( which.min(cv.errs) )


