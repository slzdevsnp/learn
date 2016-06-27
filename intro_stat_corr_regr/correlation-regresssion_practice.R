#rm(list=ls());  setwd('~/Dropbox/cs/bigdata/datacamp/intro_stat_corr_regr/'); source('correlation-regresssion_practice.R')

#rm(list=ls());  setwd('C:/Users/zimine/Dropbox/cs/bigdata/datacamp/intro_stat_corr_regr'); source('correlation-regresssion_practice.R') 

##compoute R = cov(A,B)/( std(A) * srd(B) )

#calculation on simple examples
A <- 1:3
B <- c(3,6,7)

diff_A <- A - mean(A)
diff_B <- B - mean(B)

cov <- sum ( diff_A * diff_B ) / (length(A)-1)

sq_diff_A <- diff_A^2
sq_diff_B<- diff_B^2

sd_A <- sqrt(sum(sq_diff_A)/(length(sq_diff_A)-1))
sd_B <- sqrt(sum(sq_diff_B)/(length(sq_diff_B)-1))


correlation <- cov/(sd_A*sd_B)
# R function
cor(A,B)

#creater scatter plot
PE <- read.table(file="http://assets.datacamp.com/course/Conway/Lab_Data/Stats1.13.Lab.04.txt"
	             ,header=TRUE)
# from local copy
PPE<-read.csv(file="health.csv",header=T)
head(PE)

# Scatter plots
par(mfrow=c(3,1))
plot(PE$age~PE$activeyears)
plot(PE$endurance~PE$activeyears)
plot(PE$endurance~PE$age)
par(mfrow=c(1,1))

# Correlation Analysis 
print(round(cor(PE[,2:4]), 2))
cor.test(PE$age, PE$activeyears)
cor.test(PE$age, PE$endurance)
cor.test(PE$endurance, PE$activeyears)

#chap 2
#### create impact dataset
subject<-1:40
condition<-c('control','control','control','control','control','control','control','control','control','control','control','control','control','control','control','control','control','control','control','control','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed','concussed')
vermem1<-c(95,90,87,84,92,89,78,97,93,90,89,97,79,86,85,85,98,95,96,92,79,85,97,89,75,75,84,93,88,97,93,96,84,89,95,95,97,95,92,95)
vismem1<-c(88,82,77,72,77,79,63,82,85,66,76,79,60,59,60,76,85,83,67,84,81,85,91,74,63,68,78,74,80,73,74,70,81,72,90,74,70,63,65,69)
vms1 <- c(35.29,31.47,30.87,41.87,33.28,40.73,38.09,31.65,39.59,30.53,33.65,37.51,40.39,32.88,33.39,35.13,38.51,29.64,35.32,27.36,27.19,32.66,26.29,28.92,32.77,32.92,34.26,36.08,31.63,28.89,35.81,33.61,34.46,39.18,33.14,33.03,39.01,35.06,30.58,38.45)
rt1 <- c(0.42,0.63,0.56,0.66,0.56,0.81,0.66,0.79,0.68,0.6,0.74,0.51,0.82,0.59,0.82,0.63,0.73,0.57,0.65,1,0.57,0.71,0.82,0.61,0.72,0.5,0.54,0.65,0.66,0.71,0.55,0.79,0.48,0.55,1.2,0.73,0.6,0.84,0.6,0.42)
ic1 <- c(11,7,8,7,7,6,6,10,7,10,7,7,12,2,9,10,10,8,5,11,7,9,9,9,8,9,6,10,9,7,9,7,7,10,10,11,10,5,8,11)
sym1 <-c(0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0)
vermem2 <-c(97,86,90,85,87,91,90,94,91,93,92,89,84,81,85,87,96,93,95,93,63,79,91,85,74,72,80,59,75,90,66,85,72,82,80,59,74,62,67,66)
vismem2 <-c(86,80,79,70,77,85,60,72,83,68,72,79,67,71,61,72,78,85,67,80,75,79,80,72,56,66,74,69,79,73,69,61,79,66,80,70,62,54,57,63)
vms2 <- c(35.61,37.01,20.15,33.26,28.34,33.47,44.28,36.14,37.42,25.19,23.63,26.32,43.7,32.4,39.32,35.62,39.95,35.62,30.21,30.37,29.23,44.45,26.12,27.98,60.77,31.91,49.62,35.68,55.67,25.7,35.21,33.01,37.46,53.2,33.2,34.59,39.66,35.09,32.3,44.49)
rt2 <- c(0.65,0.49,0.75,0.19,0.59,0.48,0.77,0.9,0.65,0.59,0.55,0.56,0.57,0.69,0.73,0.48,0.43,0.37,0.47,0.5,0.61,0.65,1.12,0.65,0.71,0.79,0.64,0.7,0.68,0.73,0.58,0.97,0.56,0.51,1.3,0.7,0.74,1.24,0.65,0.98)
ic2 <- c(10,7,9,8,8,5,6,10,8,11,9,9,10,3,10,12,10,9,5,11,3,6,5,5,1,9,7,11,6,3,4,3,1,7,7,4,5,2,6,5)
sym2 <-c(0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,26,34,27,22,26,35,43,31,39,25,31,38,14,16,33,13,27,15,19,39)
impact<-data.frame(subject=subject,condition=factor(condition)
				  ,vermem1=vermem1,vismem1=vismem1,vms1=vms1,rt1=rt1, ic1=ic1,sym1=sym1
				  ,vermem2=vermem2,vismem2=vismem2,vms2=vms2,rt2=rt2, ic2=ic2,sym2=sym1)

