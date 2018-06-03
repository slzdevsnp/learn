#rm(list=ls()); setwd("~/Dropbox/cs/bigdata/datacamp/fin_quant_risk_mgmt");source("quant_risk_pract_1.R", echo=T)


require(qrmdata)
require(zoo)
require(xts)
### chapter 1

data(SP500)

#head(SP500, n=3)
#tail(SP500, n=3)
## dow jones
data(DJ)

#head(DJ)
#tail(DJ)
#extracting dow jonies for two years 
dj0809 <- DJ["2008-01-01::2009-12-31"]
plot(dj0809)

data(DJ_const)
# 30 stocks that make dow jones
str(DJ_const)

dim(DJ_const)
names(DJ_const)
## get data for 2 stocks
djstocks <- DJ_const["2008/2009",c("AAPL", "GS")]
plot.zoo(djstocks)

data("GBP_USD")
data("EUR_USD")

plot(GBP_USD)
plot(EUR_USD)

fx <- merge(GBP_USD, EUR_USD, all=TRUE)

fx0015 <- fx["2010/2015",]

plot.zoo(fx0015)

### log returns
sp500x <- diff(log(SP500))[-1]  # take off first el

plot.zoo(sp500x)

#log returns for dj2008-2009
dj0809_x <- diff(log(dj0809))[-1]

djstocks_x <- diff(log(djstocks))[-1]
plot.zoo(djstocks_x)


djstocks <- DJ_const["2008/2009",c("AAPL", "AXP", "BA", "CAT")]

plot.zoo(djstocks, plot.type="single", col=c(1,2,3,4))
legend(julian(x = as.Date("2009-01-01")), y = 70, legend = names(DJ_const)[1:4], fill = 1:4)

djstocks_x <- diff(log(djstocks))
plot.zoo(djstocks_x)

##aggregate daily log returns to weeks or months, just a sum
sp500x_w <- apply.weekly(sp500x, sum) 
sp500x_m <- apply.monthly(sp500x, sum) 

