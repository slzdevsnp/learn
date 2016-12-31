rm(list=ls());  setwd('~/Dropbox/cs/bigdata/datacamp/fin_intro_portfolio_analysis/'); source('prtf_ana_practice.R')

require(xts)
require(quantmod)
require(PerformanceAnalytics)


##load aaple, msft data
tkr<-new.env()
getSymbols(c('AAPL','MSFT'), env=tkr, src="yahoo", from=as.Date("2006-01-01"),to=as.Date("2016-08-31"))


prices<-cbind(Ad(tkr$AAPL), Ad(tkr$MSFT))
returns<-Return.calculate(prices)
returns<-returns[-1,] #remove first NA line


###sp500 example

getSymbols("^GSPC", env=tkr, src = "yahoo", from = as.Date("1985-12-31") )
sp500d <- Ad(tkr$GSPC)
sp500_monthly<-Cl(to.monthly(sp500d)) #convert daily to monthy
sp500_returns <- Return.calculate(sp500_monthly)


### 1-month treasury bills from FRED
options(download.file.method="wget")
getSymbols('DGS1MO', env=tkr,src='FRED', from=as.Date("1986-01-01"))
trf<-tkr$DGS1MO
rf<-to.monthy(trf*0.01) # convert to pct