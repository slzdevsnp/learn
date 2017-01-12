#rm(list=ls()); setwd('C:/Users/Zimine/Dropbox/cs/bigdata/datacamp/fin_bond_valuation'); source("bond_valuate_pract.R")

require(Quandl)


#define pronce pricing func
bondprc <- function(p, r, ttm, y) {
  cf <- c(rep(p * r, ttm - 1), p * (1 + r))
  cf <- data.frame(cf)
  cf$t <- as.numeric(rownames(cf))
  cf$pv_factor <- 1 / (1 + y)^cf$t
  cf$pv <- cf$cf * cf$pv_factor
  return(sum(cf$pv))
}


baa<-Quandl("MOODY/DBAAYLD")

# Identify 9/30/16 yield
baa_yield <- subset(baa, baa$DATE == "2016-09-30")

# Convert yield to decimals and view
baa_yield <- baa_yield$VALUE * 0.01
print(baa_yield)
print(bondprc(p = 100, r = 0.05, ttm = 5, y = 0.0429))


##treasury data
library(quantmod)

t10yr <- getSymbols("DGS10", src="FRED", auto.assign = FALSE)
#head(t10yr)S