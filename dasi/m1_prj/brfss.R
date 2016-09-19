# setwd("C:/dasi/m1prj");source('brfss.R')

require(data.table, lib.loc = "c:/R/library")

#is_reload <-  TRUE
is_reload <- FALSE

if(is_reload){
	print('data reloaded')
	rm(list=ls())
	load(file="c:/temp/brfss2013.Rdata")
    dt13<-data.table(brfss2013)
}else{
	print('data not reloaded')
}

print (summary(dt13$physhlth) ) #poor health in last 30 days
#hist(dt13[physhlth <32 & physhlth>0.99,]$physhlth)  ## bi modal
#hist(dt13[physhlth <32 & physhlth>0.99,]$physhlth)  ## bi modal

dt13[, is_sick := factor(ifelse(physhlth >0.99 & physhlth <32, "yes", "no"))]

dt13[, is_sport_active := factor(ifelse(is.na(X_pacat1),NA
	                             ,ifelse(X_pacat1 %in%c("Highly active", "Active"), "yes", "no")))]
#	                             ,ifelse(X_pacat1 %in%c("Highly active"), "yes", "no")))]


print (summary(dt13$ftjuda1_) ) #juice
print (summary(dt13$frutda1_) )  #fruits
print (summary(dt13$vegeda1_) )  #vegetables

print('fruit and vegetable sums')
print (summary(dt13$X_frutsum) )  #fruits sum
print (summary(dt13$X_vegesum) )  #vegetables sum

# hist(dt13[X_frutsum <1000,]$X_frutsum)  ## right skewed
# hist(dt13[X_vegesum<1000]$X_vegesum)  # right skewed

frsum_med<- median(dt13[X_frutsum <1000,]$X_frutsum)
sd(dt13[X_frutsum <1000,]$X_frutsum)


vegsum_med<-median(dt13[X_vegesum<1000]$X_vegesum)
sd(dt13[X_vegesum<1000]$X_vegesum)

dt13[, hlthyfood := factor(ifelse( is.na(X_frutsum) | is.na(X_vegesum), NA 
	                   ,ifelse( X_frutsum > frsum_med & X_vegesum > vegsum_med
	                   	,"very good", "poor and average"))) ] 

# dt13[, hfood := factor(ifelse( X_frutsum > frsum_med & X_vegesum > vegsum_med
# 	                   	,"very good", "poor and average")) ] 


print (summary(dt13$hlthyfood) ) 




#hist(dt13[physhlth <32 & physhlth>0.99 & hlthyfood %in%c("very good"),]$physhlth)  

#hist(dt13[physhlth <32 & physhlth>0.99 & X_pacat1 %in%c("Highly active", "Active"),]$physhlth)  




fs<-xtabs(~is_sick+is_sport_active, data=dt13)

p_is_sick <- nrow(dt13[is_sick=="yes",]) / nrow(dt13[!is.na(is_sick),])
p_is_sport <- nrow(dt13[is_sport_active=="yes",]) / nrow(dt13[!is.na(is_sport_active),])

p_is_sick_and_sport <- fs[2,2] /sum(fs)

p_is_sick_given_sport <- p_is_sick_and_sport / p_is_sport


ff<-xtabs(~is_sick+hlthyfood, data=dt13)

p_is_hlfood <- nrow(dt13[hlthyfood%in%c("very good"),]) / nrow(dt13[!is.na(hlthyfood),])

p_is_hlfood_and_sick <- ff[2,2] / sum(ff)

p_is_sick_given_hlfood <- p_is_hlfood_and_sick / p_is_hlfood 
## goood
print(paste('p is sick', p_is_sick))
print(paste('p is sick given sport', p_is_sick_given_sport))
print(paste('p is sick given healthy food', p_is_sick_given_hlfood))




#end
