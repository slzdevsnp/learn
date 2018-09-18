# setwd("~/Dropbox/cs/bigdata/datacamp/dswr_visual_ggplot/part1"); source("ggplot_pract.R")

require(ggplot2)
require(tidyverse)
require(data.table)
library(repr)
options(repr.plot.width=4, repr.plot.height=3)


testplot <- function(meansdf)
{
  p <- ggplot(meansdf, 
              aes(fill = condition,
                  y = means,
                  x = condition))
  p + geom_bar(position = "dodge", stat = "identity")
  return(p)
}

testplot1 <- function(meansdf, xvar = "condition", yvar = "means",
                     fillvar = "condition") {
    p <- ggplot(meansdf,
                aes_string(x = xvar, y= yvar, fill = fillvar)) +
             geom_bar(position="dodge", stat="identity") +
             labs(x="variable condition", y="variable means")
    return(p)
}


##main
m <- c(13.8, 16.9, 14.8 )
cond <- c(1,3, 2)
means <- data.frame(means=m, condition=cond)


p<-testplot1(means)
print(p)

## from leslie 

# years<-c('1980','1990','2000','2010')
# id <- 1:4
# temper <-c(rep('cold',2),rep('hot',2))
# df<-data.table(years,id,temper)

  
# p<-ggplot(data=df, mapping=aes(x=years,y=id) ) +
#  geom_point()
# print(p)



