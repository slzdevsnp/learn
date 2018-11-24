require(quantmod)

## load data from  url  or from a local rdat file 

tickers<-c("^GSPC")

tk<-'IBM'
tser<-getSymbols(tk,src="yahoo", auto.assign=F,from='2000-01-01')

barChart(tser)
barChart(tser["2018-01-01::"])
candleChart(tser["2018-01-01::"],theme="white")
chartSeries(tser)
prd="2018-01-01::"

chartSeries(tser["2018-01-29::2018-02-15"], show.grid=F, line.type="l", TA=NULL)

lineChart(tser["2018-01-29::2018-02-15"], show.grid=F, TA=NULL,  line.type='l',  theme="white.mono")

prd="2018-06-10::2018-07:08"; candleChart(tser,TA=NULL,subset=prd, theme="white.mono", show.grid=F)

##good examples
#GS
prd="2018-06-10::2018-07:08"; candleChart(tser,TA=NULL,subset=prd, theme="white.mono", show.grid=F)
#or different style


##defining your won theme
myTheme <- chart_theme()
myTheme$format.labels <- '%d'
myTheme$col$dn.col <-"black"
myTheme$col$up.col <-"black"

chart_Series(tser[prd], theme=myTheme)

