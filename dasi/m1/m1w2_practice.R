#rm(list=ls());setwd("c:/Users/zimine/Dropbox/cs/bigdata/coursera/dasi/m1/");source("m1w2_practice.R")


library(statsr)
library(dplyr)
library(ggplot2)

#load data on nyc plane flights and their delays
data(nycflights)

str(nycflights)

names(nycflights)

###dplyr way . available functions
# filter()
# arrange()
# select()
# distinct()
# mutate()
# summarise()
# sample_n()

##summary statistics functions
# mean
# median
# sd
# var
# IQR
# range
# min
# max


ggplot(data = nycflights, aes(x = dep_delay)) +
  geom_histogram(binwidth = 15)

rdu_flights <- nycflights %>%
filter(dest == "RDU")

print(
ggplot(data = rdu_flights, aes(x = dep_delay)) +
  geom_histogram()
)

##summary stats
print(
rdu_flights %>%
  summarise(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), n = n())
)


sfo_feb_flights <- nycflights %>%
  filter(dest == "SFO", month == 2)

print(nrow(sfo_feb_flights))

print(
ggplot(data = sfo_feb_flights, aes(x = arr_delay)) +
  geom_histogram()
)

print(
sfo_feb_flights %>%
  summarise(mean_ad = mean(arr_delay), sd_dd = sd(arr_delay), n = n())
)

##grouping with dplyr
rdu_flights %>%
  group_by(origin) %>%
  summarise(mean_dd = mean(dep_delay), sd_dd = sd(dep_delay), n = n())

sfo_feb_flights %>%
group_by(carrier) %>%
summarise(arr_med=median(arr_delay), arr_iqr=IQR(arr_delay))

#Which month would you expect to have the highest
# average delay departing from an NYC airport?

nycflights %>%
  group_by(month) %>%
  summarise(mean_dd = mean(dep_delay)) %>%
  arrange(desc(mean_dd))

  nycflights %>%
  group_by(month) %>%
  summarise(med_dd = median(dep_delay)) %>%
  arrange(desc(med_dd))

#nice plot of 12 boxplots
  ggplot(nycflights, aes(x = factor(month), y = dep_delay)) +
  geom_boxplot()


