#rm(list=ls());  setwd('~/Dropbox/cs/bigdata/datacamp/intro_stat_repeated_anova/'); source('repeated_anova_practice.R')

## course 4 repeated anova

 #working memory data set
#condition how many days training lasted
#iq  gain in iq
#subject a person's id 
condition<-c('8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','8 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','12 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','17 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days','19 days')
iq<-c(12.4,11.8,14.6,7.7,15.7,11.6,7,8.4,10.7,10.6,5.4,12.3,9.3,11,11.9,14.1,12.1,13.2,8.8,9.6,12.5,11.6,8.9,8.3,10.9,13.4,12.3,8.7,9.7,9.7,6.9,10.5,11.6,13.8,15.6,11.7,16.1,11.7,15,15.1,13.4,9.8,13.2,12.8,18.1,13.8,14.5,17.2,14.2,10.4,12,17.4,12.8,12.5,14.6,15.6,13.2,11.2,15.4,16,14,17,10.4,11.3,18.9,16.7,13.9,19.2,14.2,11.5,15.5,12.5,16.1,11.1,16.1,15.2,15.4,16.8,13.5,15.7)
subject <- rep(1:20,4)
wm<-data.frame(subject=factor(subject), condition=factor(condition, levels=c('8 days', '12 days', '17 days', '19 days')),iq=iq)
# Summary statistics by all groups
describeBy(wm)

boxplot(wm$iq ~ wm$condition, main="Boxplot", xlab="Training days", ylab="IQ")

library(ggplot2)
ggplot(data = wm, aes(x = sort(condition), y = iq, group = subject, colour = subject)) + 
  geom_line() + geom_point()


