require(quantmod)


isDld<-FALSE
#isDld<-TRUE

tk<-'GS'
prd <- "2018-06-10::2018-07:08"

if (isDld){
   print("loading from network..")
   tser<-getSymbols(tk,src="yahoo", auto.assign=F,from='2000-01-01')
}else{
 cat("load data from the local file ")
 fn<-'~/mydata.rdat'
 load(fn)
}


#charting
myTheme <- chart_theme()
myTheme$format.labels <- '%d'
myTheme$col$dn.col <-"black"
myTheme$col$up.col <-"black"

#myTheme$col$dn.border <- "#F0F0F0"
#myTheme$col$up.border <- "#F0F0F0"

#myTheme$col$labels <- "#F0F0F0"

myTheme$rylab <- FALSE
myTheme$lylab <- FALSE
myTheme$grid.ticks.lwd <- 0
myTheme$grid.ticks.on <- "years"
myTheme$coarse.time <- FALSE


png(filename='~/mychart.png', width=180,height=200)
cc<-chart_Series(tser[prd], theme=myTheme)
plot(cc)
dev.off()




