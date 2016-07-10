#rm(list=ls());  setwd('~/Dropbox/cs/bigdata/datacamp/intro_ml'); source('iml_practice.R')

#rm(list=ls());  setwd('C:/Users/zimine/Dropbox/cs/bigdata/datacamp/intro_ml'); source('iml_practice.R') 

##create titanic dataset
survived<-c('0','1','1','1','0','0','0','1','1','1','1','0','0','0','1','0','0','0','1','1','1','0','1','0','0','0','0','0','0','0','1','0','0','1','1','0','0','0','1','1','0','1','0','1','0','0','1','0','0','1','0','1','0','0','0','0','0','1','0','1','1','0','1','0','1','1','0','1','0','0','0','0','0','0','0','1','1','0','0','0','0','0','0','1','0','0','0','0','0','0','0','0','0','0','0','0','0','1','0','1','1','0','0','0','0','1','0','0','1','0','0','0','1','1','0','0','0','1','0','0','0','0','1','0','0','0','1','0','0','1','0','0','0','1','0','0','0','0','1','0','0','0','0','0','0','0','1','1','1','0','0','1','0','1','1','1','1','0','0','0','0','0','1','0','0','1','1','1','0','1','0','0','1','1','0','1','0','1','0','0','1','0','1','0','0','1','0','0','1','0','0','1','0','0','0','0','0','0','0','1','1','0','0','0','0','0','1','1','1','1','1','0','0','0','0','1','1','1','1','1','0','1','0','0','1','0','0','0','1','0','1','0','1','1','1','1','0','0','0','0','0','1','0','1','1','0','1','1','1','0','0','0','1','1','0','1','1','0','0','1','1','1','0','1','1','1','0','0','0','0','1','1','0','1','1','0','0','0','1','1','1','0','0','0','0','0','1','0','0','0','0','0','0','1','1','1','0','0','0','0','1','0','0','0','1','1','0','1','0','0','1','1','1','1','0','1','1','0','0','0','0','1','1','0','0','0','0','0','0','1','0','1','1','1','1','0','0','0','0','0','0','1','1','1','1','1','0','0','1','0','1','0','0','1','0','0','1','1','1','1','1','1','0','0','1','1','0','1','1','0','0','0','0','0','1','0','1','1','0','0','0','0','1','0','0','1','1','1','0','0','1','0','0','0','0','1','0','0','0','0','0','1','0','1','0','1','1','1','1','0','0','1','1','0','1','0','1','0','1','0','0','1','0','0','1','0','1','1','1','0','0','1','0','0','1','0','1','1','0','1','1','0','1','1','1','0','0','0','0','0','1','1','1','1','0','0','1','1','1','1','1','0','0','1','0','1','0','0','1','0','0','0','0','1','1','0','1','0','0','1','1','1','0','0','1','0','0','1','0','0','1','1','0','0','0','0','1','0','1','0','1','0','1','0','0','0','0','1','0','1','1','0','1','1','1','0','0','0','0','0','0','1','0','0','0','1','0','0','0','1','0','0','1','0','0','1','0','1','1','0','0','0','0','0','0','0','1','1','1','0','0','0','0','0','0','1','1','0','0','0','0','1','1','1','1','1','0','0','0','1','1','0','1','0','0','0','1','0','1','0','0','1','0','0','0','0','0','1','0','1','0','1','0','0','1','0','0','1','1','0','0','1','1','0','0','0','1','0','1','1','0','1','0','0','0','0','0','1','0','1','1','1','1','0','0','0','1','0','1','0','0','0','0','1','1','0','0','0','1','1','1','1','0','0','0','0','1','0','0','0','0','0','0','0','0','0','1','1','0','1','0','1','1','1','1','0','0','1','0','1','0','0','1','0','0','0','0','0','0','0','0','1','0','1','1','1','1','0','0','1','0','1','1','0','1','0','1','0','0','1','1','0','0','1','1','0','0','0','0','0','0','1','1','0')
pclass <-c(3,1,3,1,3,1,3,3,2,3,1,3,3,3,2,3,3,2,2,3,1,3,3,1,1,2,1,1,3,3,3,3,2,2,3,3,3,3,1,2,1,2,3,2,3,3,1,1,3,2,3,3,3,2,3,2,3,3,3,2,3,3,3,1,2,3,3,1,3,3,3,1,3,3,1,1,2,2,3,1,3,3,3,3,3,1,3,3,3,3,3,3,2,1,3,2,2,2,1,3,3,3,3,3,3,2,2,2,1,1,3,1,3,3,3,2,2,3,3,2,2,2,1,3,3,1,3,3,3,2,3,3,3,3,3,3,1,3,3,3,1,3,1,2,3,3,2,3,1,3,3,2,2,3,2,1,1,3,2,3,3,3,3,3,3,3,3,1,3,2,3,2,1,3,2,1,2,3,2,3,1,3,2,3,2,1,3,2,3,2,2,2,2,2,2,3,3,1,3,2,1,2,3,1,3,3,3,1,1,2,3,1,1,2,3,3,1,1,3,2,1,1,3,3,3,3,3,3,3,3,3,3,2,3,1,1,2,3,3,3,1,1,3,1,1,2,1,1,1,2,3,2,3,2,2,1,1,3,3,2,2,1,3,2,3,1,1,1,3,1,1,3,1,2,1,2,2,2,2,2,3,3,3,3,3,3,1,2,3,2,3,3,3,1,1,1,3,3,1,3,3,1,3,3,1,3,3,1,2,3,2,2,1,3,3,1,3,3,3,2,2,2,3,3,3,3,3,2,3,2,3,1,3,2,2,2,3,3,3,3,3,2,2,3,1,2,3,1,1,3,2,1,2,2,3,3,2,1,2,1,3,1,2,1,1,3,1,2,1,3,1,2,3,1,3,3,2,2,3,2,3,3,3,3,3,3,1,1,1,3,3,3,1,1,3,1,1,3,3,3,3,1,1,2,3,3,3,1,1,3,1,2,2,3,1,3,1,3,2,3,2,2,3,3,2,1,1,1,1,3,3,2,1,1,2,3,2,1,2,3,3,1,1,1,3,3,2,3,3,3,3,2,1,1,3,3,2,1,3,2,1,2,1,1,2,1,3,3,1,3,2,3,3,1,2,3,1,3,3,1,2,1,3,3,2,3,3,2,2,3,1,3,3,3,1,2,1,3,1,3,1,3,2,3,2,3,3,1,3,3,1,3,1,3,2,3,3,2,3,2,1,1,3,1,3,3,2,2,3,2,1,2,2,3,3,3,3,1,1,3,3,2,2,3,3,3,1,1,3,3,1,2,3,1,3,1,1,3,3,3,2,2,1,1,1,1,3,2,3,1,2,3,2,3,2,2,1,3,2,2,3,1,3,2,2,3,3,1,1,1,3,3,1,3,2,1,3,2,3,3,3,2,2,3,2,3,1,3,3,1,3,1,3,3,3,3,2,2,3,3,1,3,1,1,3,3,3,3,3,1,2,3,2,1,3,3,3,2,2,1,3,3,3,1,3,2,1,3,3,2,3,3,3,2,3,3,1,3,1,3,3,2,1,3,2,3,3,1,3,3,3,2,1,3,3,3,3,2,3,3,3,1,2,3,1,1,3,3,2,1,2,2,2,1,3,3,1,1,3,2,3,3,3,1,2,3,3,2,3,3,2,1,1,3)
sex<-c('male','female','female','female','male','male','male','female','female','female','female','male','male','female','female','male','female','male','male','female','male','female','female','male','male','male','male','male','male','female','female','female','female','female','female','female','male','male','female','female','male','female','male','female','male','male','female','male','male','female','male','female','male','male','female','male','male','male','male','male','female','male','male','male','female','female','male','female','male','male','male','male','male','male','male','male','female','male','female','male','male','male','male','female','male','male','female','male','female','female','male','male','male','male','female','male','male','female','male','male','male','male','male','male','female','female','male','male','female','male','male','male','female','female','male','male','male','male','female','male','male','male','female','male','male','male','female','male','male','female','male','male','male','male','female','male','male','male','female','male','male','male','female','male','male','male','male','female','male','male','male','female','male','female','male','female','female','male','female','male','male','male','male','female','male','male','female','male','male','female','male','male','female','female','male','female','male','male','male','male','male','male','male','male','male','female','male','male','female','male','male','female','male','male','male','male','male','male','female','female','male','male','female','male','male','female','female','female','female','female','male','male','male','male','male','male','female','female','male','female','male','female','female','male','female','male','male','male','male','male','male','male','male','female','female','female','male','female','male','male','female','female','male','male','female','male','female','female','female','female','male','male','female','female','male','female','female','male','male','female','female','female','male','female','female','female','male','male','male','male','female','male','male','male','female','male','male','male','female','female','male','male','male','male','male','male','female','female','male','male','female','male','male','female','female','male','male','male','male','female','female','male','male','male','female','female','male','female','male','male','female','female','male','male','male','female','female','male','female','male','male','female','male','male','female','male','female','male','male','male','male','female','male','female','female','male','female','male','male','female','male','female','female','male','male','female','male','male','female','female','female','male','male','female','male','male','female','male','female','male','female','male','male','male','male','male','male','female','male','male','male','male','male','male','female','male','female','female','female','male','male','male','female','male','male','female','male','female','male','male','male','male','male','male','male','female','female','male','male','female','female','female','male','female','male','male','male','male','female','male','male','female','female','male','female','male','female','male','female','male','male','female','male','female','female','male','female','female','female','female','female','male','male','male','female','male','male','male','male','male','female','male','female','female','female','male','male','male','male','female','male','male','female','male','male','male','female','female','male','female','female','male','male','female','male','male','male','male','female','male','male','male','male','male','female','male','male','male','male','male','female','female','female','male','female','male','female','female','male','male','male','male','male','male','male','male','female','male','male','male','male','female','female','male','male','female','male','female','female','female','male','male','male','female','female','male','female','male','female','male','male','male','male','male','male','male','male','male','male','female','male','male','male','male','male','female','female','male','male','male','male','male','male','male','male','male','female','male','female','male','male','male','male','male','male','female','male','female','male','male','male','female','male','female','female','male','male','male','male','female','female','male','female','male','male','male','male','male','female','male','female','female','male','male','male','male','female','male','male','female','male','male','male','male','female','male','male','female','male','male','male','female','male','male','male','male','female','male','male','female','male','female','female','male','male','male','female','female','male','female','female','female','female','male','male','male','female','male','male','male','male','male','male','female','female','male','female','male','female','male','male','male','male','male','female','male','female','male','male','male','female','male','female','male','male','male','female','male','male','female','male','male','female','female','male','male','male','female','male','male','male','male','female','male','male','male','male','male','male','male','female','female','female','female','female','male','female','male','male','female','male','female','female','male','male','male','female','male','male','female','female','male','male','female','female','male','female','male','male','female','male','female','male','male')
age<-c(22,38,26,35,35,54,2,27,14,4,58,20,39,14,55,2,31,35,34,15,28,8,38,19,40,66,28,42,21,18,14,40,27,3,19,18,7,21,49,29,65,21,28.5,5,11,22,38,45,4,29,19,17,26,32,16,21,26,32,25,0.83,30,22,29,28,17,33,16,23,24,29,20,46,26,59,71,23,34,34,28,21,33,37,28,21,38,47,14.5,22,20,17,21,70.5,29,24,2,21,32.5,32.5,54,12,24,45,33,20,47,29,25,23,19,37,16,24,22,24,19,18,19,27,9,36.5,42,51,22,55.5,40.5,51,16,30,44,40,26,17,1,9,45,28,61,4,1,21,56,18,50,30,36,9,1,4,45,40,36,32,19,19,3,44,58,42,24,28,34,45.5,18,2,32,26,16,40,24,35,22,30,31,27,42,32,30,16,27,51,38,22,19,20.5,18,35,29,59,5,24,44,8,19,33,29,22,30,44,25,24,37,54,29,62,30,41,29,30,35,50,3,52,40,36,16,25,58,35,25,41,37,63,45,7,35,65,28,16,19,33,30,22,42,22,26,19,36,24,24,23.5,2,50,19,0.92,17,30,30,24,18,26,28,43,26,24,54,31,40,22,27,30,22,36,61,36,31,16,45.5,38,16,29,41,45,45,2,24,28,25,36,24,40,3,42,23,15,25,28,22,38,40,29,45,35,30,60,24,25,18,19,22,3,22,27,20,19,42,1,32,35,18,1,36,17,36,21,28,23,24,22,31,46,23,28,39,26,21,28,20,34,51,3,21,33,44,34,18,30,10,21,29,28,18,28,19,32,28,42,17,50,14,21,24,64,31,45,20,25,28,4,13,34,5,52,36,30,49,29,65,50,48,34,47,48,38,56,0.75,38,33,23,22,34,29,22,2,9,50,63,25,35,58,30,9,21,55,71,21,54,25,24,17,21,37,16,18,33,28,26,29,36,54,24,47,34,36,32,30,22,44,40.5,50,39,23,2,17,30,7,45,30,22,36,9,11,32,50,64,19,33,8,17,27,22,22,62,48,39,36,40,28,24,19,29,32,62,53,36,16,19,34,39,32,25,39,54,36,18,47,60,22,35,52,47,37,36,49,49,24,44,35,36,30,27,22,40,39,35,24,34,26,4,26,27,42,20,21,21,61,57,21,26,80,51,32,9,28,32,31,41,20,24,2,0.75,48,19,56,23,18,21,18,24,32,23,58,50,40,47,36,20,32,25,43,40,31,70,31,18,24.5,18,43,36,27,20,14,60,25,14,19,18,15,31,4,25,60,52,44,49,42,18,35,18,25,26,39,45,42,22,24,48,29,52,19,38,27,33,6,17,34,50,27,20,30,25,25,29,11,23,23,28.5,48,35,36,21,24,31,70,16,30,19,31,4,6,33,23,48,0.67,28,18,34,33,41,20,36,16,51,30.5,32,24,48,57,54,18,5,43,13,17,29,25,25,18,8,1,46,16,25,39,49,31,30,30,34,31,11,0.42,27,31,39,18,39,33,26,39,35,6,30.5,23,31,43,10,52,27,38,27,2,1,62,15,0.83,23,18,39,21,32,20,16,30,34.5,17,42,35,28,4,74,9,16,44,18,45,51,24,41,21,48,24,42,27,31,4,26,47,33,47,28,15,20,19,56,25,33,22,28,25,39,27,19,26,32)

titanic_t <- data.frame(Survived=factor(survived), Pclass=pclass,Sex=factor(sex), Age=age)
write.csv(titanic_t,file='titanic.csv', row.names=FALSE)
titanic<-read.csv(file='titanic.csv', header=TRUE)
set.seed(1)
# A decision tree classification model is built on the data
library(rpart)
tree <- rpart(Survived ~ ., data = titanic, method = "class") #survived response, predictors all others
pred<-predict(tree, titanic, type='class')
conf<-table(titanic$Survived, pred) # make a confusion matrix
print(conf)

### compute accuracy, precision and recall
TP <- conf[1,1] 
FN <- conf[1,2] 
FP <- conf[2,1] 
TN <- conf[2,2] 

accuracy <- (TP + TN) / (TP+FN+FP+TN)
accuracy
precision <- TP/ (TP + FP)
precision 
recall <- TP / (TP + FN)
recall 

seeds <- read.csv(file='seeds.csv', row.names=1, header=T)

km_seeds <- kmeans(seeds, 3)
plot(length ~ compactness, data = seeds, col=km_seeds$cluster)
print(km_seeds$tot.withinss / km_seeds$betweenss)

### titanic example with  a dataset spilt between train and test sets
set.seed(1)
n <- nrow(titanic) # number of observations
shuffled <- titanic[sample(n),] #shuffle the dataset
pct_split<-0.7
train_indices <- 1:round(pct_split * n)
train <- shuffled[train_indices, ]
test_indices <- (round(pct_split * n) + 1):n
test <- shuffled[test_indices, ] # the rest of the dataset

#fill the model but on the training set
tree <- rpart(Survived ~ ., train, method = "class")
# Predict the outcome on the test set with tree:
pred<-predict(tree, test, type='class')
# Calculate the confusion matrix: conf
conf<-table(test$Survived, pred)
print(conf)
print(paste("accuracy:" , sum(diag(conf))/sum(conf) ))

##cross valiation
# run 6 times with moving train set and data set
npass <- 6
accs <- rep(0,6) # a vec of accurencies
n<- nrow(shuffled)
for (i in 1:6) {
  # These indices indicate the interval of the test set
  indices <- (( (i-1) * round((1/npass)*n)) + 1):((i*round((1/npass) * n)))
  
  test <- shuffled[indices,] #indices are indexesof test set
  train <- shuffled[-indices,] #train is the rest
  tree <- rpart(Survived ~ ., train, method = "class")
  pred<-predict(tree, test, type='class')  
  conf<-table(test$Survived, pred)
  accs[i] <- sum(diag(conf))/sum(conf)
}

# Print out the mean of accs
print(paste("cross validation on 6 runs " ,mean(accs)))


### check the performance of classifier on two emails data sets
emails_small <- read.csv(file='emails_small.csv', header=T, row.names=1,colClasses=c('numeric','numeric','factor') )
emails_small$spam <- factor(emails_small$spam, levels=c("1", "0")) #rearrange factor levels
spam_classifier <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 4] <- 1
  prediction[x >= 3 & x <= 4] <- 0
  prediction[x >= 2.2 & x < 3] <- 1
  prediction[x >= 1.4 & x < 2.2] <- 0
  prediction[x > 1.25 & x < 1.4] <- 1
  prediction[x <= 1.25] <- 0
  return(factor(prediction, levels=c("1","0")))
}

pred_small<-spam_classifier(emails_small$avg_capital_seq) #apply spam classifier
conf_small<-table(emails_small$spam, pred_small) #confusion matrix
acc_small <- sum(diag(conf_small))/sum(conf_small)
print(paste("accuracy for emails_small", acc_small)) #accuracy for emails set


### now on much bigger set
emails_full <- read.csv(file='emails_full.csv', header=T, row.names=1,colClasses=c('numeric', 'numeric', 'factor') )
emails_full$spam <- factor(emails_full$spam, levels=c("1", "0")) #rearrange factor levels

pred_full<-spam_classifier(emails_full$avg_capital_seq)
conf_full<-table(emails_full$spam, pred_full)
acc_full <- sum(diag(conf_full))/sum(conf_full)
print(paste("accuracy for emails_full",acc_full)) #accuracy for emails_full


#### now repeat exercise with indroducing bias to the model 
spam_classifier <- function(x){
  prediction <- rep(NA,length(x))
  prediction[x > 4] <- 1
  prediction[x <= 4 ] <- 0
  return(factor(prediction, levels=c("1","0")))
}
conf_small <- table(emails_small$spam, spam_classifier(emails_small$avg_capital_seq))
print(conf_small)
acc_small <- sum(diag(conf_small)) / sum(conf_small)
print(acc_small)

conf_full <- table(emails_full$spam, spam_classifier(emails_full$avg_capital_seq))
print(conf_full)
acc_full <- sum(diag(conf_full)) / sum(conf_full)

print(acc_full)



#end
