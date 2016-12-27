rm(list=ls());  setwd('~/Dropbox/cs/bigdata/datacamp/fin_intro_portfolio_analysis/'); source('prtf_ana_practice.R')

require(xts)
require(quantmod)
require(PerformanceAnalytics)


##load aaple, msft data
ticker<-new.env()
getSymbols(c('AAPL','MSFT'), env=ticker, src="yahoo", from=as.Date("2006-01-01"),to=as.Date("2016-08-31"))


prices<-cbind(Ad(ticker$AAPL), Ad(ticker$MSFT))
returns<-Return.calculate(prices)
returns<-returns[-1,] #remove first NA line