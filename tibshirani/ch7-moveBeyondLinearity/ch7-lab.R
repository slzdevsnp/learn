##ch7-lab


# rm(list=ls());setwd("~/Dropbox/cs/bigdata/lagunita/tibshirani/ch7-moveBeyondLinearity/");source("ch7-lab.R")


require(ISLR)

data(Wage)
attach(Wage)
##polynomials
fit <- lm(wage~poly(age,4),data=Wage) #poly degree 4 on 1 predictor 
print(summary(fit))

##plot of function
#```{r fig.width=7, fig.height=6}
agelims <- range(age)
age.grid <- seq(from=agelims[1], to=agelims[2])
preds <- predict(fit,newdata=list(age=age.grid), se=TRUE  )
se.bands <- cbind(preds$fit+2*preds$se  , preds$fit-2*preds$se )
plot(age,wage,col="darkgrey")
lines(age.grid, preds$fit, lwd=2, col="blue")
matlines(age.grid, se.bands,col="blue", lty=2)


## with I()
fita <- lm(wage~age+I(age^2)+I(age^3)+I(age^4), data=Wage)
print(summary(fita))

plot(fitted(fit), fitted(fita))

##compare a sequence of nested models with anova
fita <- lm(wage~education,data=Wage)
fitb <- lm(wage~education+age,data=Wage)
fitc <- lm(wage~education+poly(age,2), data=Wage)
fitd <- lm(wage~education+poly(age,3), data=Wage)

print(anova(fita,fitb,fitc,fitd))

##logisitc regression
## applied to high earners

lgfit <- glm(I(wage>250) ~ poly(age,3), data=Wage, family=binomial)
print(summary(fit))

preds <- predict(lgfit, list(age=age.grid), se=TRUE)
se.bands <- preds$fit + cbind(fit=0, lower=-2*preds$se, upper=2*preds$se)

print(se.bands[1:5,] )


prob.bands <- exp(se.bands) / (1+exp(se.bands))
matplot(age.grid, prob.bands,col="blue", lwd=c(2,1,1), lty=c(1,2,2),
        type="l", ylim=c(0,.1)  )
points(jitter(age), I(wage>250)/10, pch="l", cex=.5)

##### Splines

require(splines)
fit<-lm(wage~bs(age,knots=c(25,40,60)), data=Wage )

#print(summary(fit))
plot(age,wage, col="darkgrey")
lines(age.grid, predict(fit, list(age=age.grid)),col="darkgreen",lwd=2 )
abline(v=c(25,50,60), lty=2, col="darkgreen" )

