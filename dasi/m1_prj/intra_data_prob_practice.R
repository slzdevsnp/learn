#rm(list=ls());setwd("c:/Users/zimine/Dropbox/cs/bigdata/coursera/dasi/m1_prj/");source("intra_data_prob_practice.R")


library(statsr)
library(dplyr)
library(ggplot2)
library(data.table)




##load data
load("brfss2013.Rdata")

br<-data.table(brfss2013)



