#rm(list=ls());  setwd('~/Dropbox/cs/bigdata/datacamp/intro_stat_corr_regr/'); source('correlation-regresssion_practice.R')

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
describe(PE)

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




