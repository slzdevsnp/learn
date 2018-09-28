# setwd("~/Dropbox/cs/bigdata/datacamp/datan_datatable_way"); source("dt_sheet_pract.R")

library(data.table)
set.seed(45L)


DT <- data.table(V1=c(1L,2L),
                V2=LETTERS[1:3],
                V3=round(rnorm(4),4),
                V4=1:12)


DT
##subsetting
DT[3:5,]

DT[V2=="A"]

DT[ V2 %in% c("A","C")]

## Manipulating on Columns in J

DT[,.(V2,V3)]

DT[,sum(V1)]

DT[,.(sum(V1),sd(V1))]

DT[,.(Aggr.V1=sum(V1),sd.V1=sd(V1))] #name new columns

DT[, .(print(V2),  #prints a row of V2 and makes a plot of V3
       plot(V3),
       NULL)]

###  Doing j by Group 
DT[, .(V4.Sum=sum(V4)),by=V1] #sum of V4 grouped by V1
DT[, .(V4.Sum=sum(V4)),by=.(V1,V2)] #sum of V4 grouped by V1 and V2

DT[, .N, by=V1] #counts of rows grouped by V1


### AddingUpdating Columns by reference in j using:=
DT[, V1EX:=round(exp(V1),2)] #adds new column

DT[, c("V1","V2"):=list( round(exp(V1),2),LETTERS[4:6]) ] #update V1 and V2

DT[, V1:=NULL] #drop V1 col 
DT[, c("V1","V2"):=NULL] #drop V1 and V2


DT[, c("V1","V2"):=list(c(1L,2L),LETTERS[1:3] ) ] #readding V1 and V2

## Indexing and Keys 
setkey(DT,V2)
DT["A"] #return all rows  with key == A 
DT[c("A","C")]  #return all rows with key %in%  A and C 


DT[c("A","C"), sum(V4)  ]  #return sum of v4 on rows filterd on key


DT[c("A","C"), sum(V4), by=.EACHI ]  #return sum of v4 for each value of key

setkey(DT, V1,V2) #set key based on two columns and sort DT on this keys

DT[.(2,"C")] #only rows which match values in key
DT[ .(2,c("A","C"))] #same as above but V@ can has values 1 or 2

### Advanced Data Table Operations 

DT[,.N] #return number of rows
DT[.N-1] #return penultimate row of DT (last -1)
DT[,.(V2,V3)] #return list of columns as data table
DT[,mean(V3), by=.(V1,V2)] #return a func applied to a column grouped by a vec 

## .SD & .SDcols
DT[,print(.SD), by=V2]
DT[, lapply(.SD,sum), by=V2] #apply sum to all columns, grouped by V2 
DT[, lapply(.SD,sum), by=V2, .SDcols=c("V3", "V4")] #same as above for specified cols
DT[, lapply(.SD,sum), by=V2, .SDcols=paste0("V",3:4)] #same, construct colnames 


## chaining 
XDT <- DT[,.(V4sum=sum(V4)),by=V1 ]
XDT[V4sum>40]

DT[,.(V4sum=sum(V4)),by=V1][V4sum>40] #chaining of two operations
DT[,.(V4sum=sum(V4)),by=V1][order(-V1)] #compute grouped, ordered desc 

##set() family 
rows <- list(3:4,5:6)
cols <- 1:2
for (i in seq_along(rows)){
    set(DT, i=rows[[i]], j=cols[i],value=NA)  #setting i,j to NA with set
}

##setnames()

setnames(DT, "V2", "Rating") #rename column
setnames(DT, c("Rating", "V3"), c("V2.rating", "V3.DC")) #rename columns

setcolorder(DT, c("V2.rating","V1", "V4", "V3.DC")) #reorder columns 


##merging 
DT <- data.table(V1=c(1L,2L),
                V2=LETTERS[1:3],
                V3=round(rnorm(4),4),
                V4=1:12)

setkey(DT,V1,V2)

DTX <- data.table(V1=c(1L,2L),
                V2=LETTERS[1:4],
                V3x=round(runif(4),4),
                V4x=1:8 )
setkey(DTX,V1,V2)

MDTX <-merge(DT,DTX) #like inner join  12 rows
merge(DT,DTX,all=TRUE) # like full outer join 
merge(DT,DTX,all.x=T) #like outer left join
merge(DT,DTX,all.y=T) #like outer right join






