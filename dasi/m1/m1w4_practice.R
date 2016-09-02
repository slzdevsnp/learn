#rm(list=ls());setwd("c:/Users/zimine/Dropbox/cs/bigdata/coursera/dasi/m1/");source("m1w4_practice.R")


library(statsr)
library(dplyr)
library(ggplot2)

load("selected_nzes2011.Rdata")


##columns of interest jpartyvote, jdiffvoting, and _singlefav

#jpartyvote	C3: if cast party vote, for which party
#jdiffvoting	A13: does voting make any difference to what happens
#_singlefav	Calculated Variable of most liked of major parties Question A14


#first question
selected_nzes2011 %>% 
  select(jpartyvote, jdiffvoting, X_singlefav) %>% 
  str()

s_nzes2011 <- selected_nzes2011 %>% 
  select(jpartyvote, jdiffvoting, X_singlefav)

## diagnose the problem of first question
print(
grep("singlefav", names(selected_nzes2011), value = TRUE)
 )
#end
print(
selected_nzes2011 %>% 
  group_by(jpartyvote) %>% 
  summarise(count = n())

  )

#filter out "Don't know"
print(
selected_nzes2011 %>% 
  filter(jpartyvote != "Don't know") %>%
  group_by(jpartyvote) %>% 
  summarise(count = n())

)

print(
selected_nzes2011 %>% 
  group_by(X_singlefav) %>% 
  summarise(count = n())
	)

##filtering out NAs
print(
selected_nzes2011 %>% 
  filter(!is.na(X_singlefav)) %>%
  group_by(X_singlefav) %>% 
  summarise(count = n())
)

print(
selected_nzes2011 %>% 
  group_by(jdiffvoting) %>% 
  summarise(count = n())
)

##adding new column
selected_nzes2011 <- selected_nzes2011 %>%
mutate(sameparty = ifelse(jpartyvote == X_singlefav, "same", "different"))

#multi-criteria grouping involving a new variable
print(
selected_nzes2011 %>%
group_by(jpartyvote, X_singlefav,sameparty) %>% summarise(count=n())
)
## look at stats only for the same
print(
selected_nzes2011 %>%
 group_by(jpartyvote, X_singlefav,sameparty) %>% 
 summarise(count=n()) %>%
 filter(sameparty=="same")

)


#can also check how we got any NAs 
print(
selected_nzes2011 %>% 
  group_by(jpartyvote, X_singlefav, sameparty) %>%
  summarise(count = n()) %>% 
  filter(is.na(sameparty))
)

##question one is about filtering out NAs and summarizing with counts

##########################
## 2nd question  
###########################
# jnzflike	A14: how much like NZ First
# jage	Respondent’s age in years

print(str(selected_nzes2011$jnzflike))
print(str(selected_nzes2011$jage))

# summarize over a factor variable
print(
selected_nzes2011 %>% 
  group_by(jnzflike) %>% 
  summarise(count = n())
)

print(
selected_nzes2011 %>% 
filter(!is.na(jage)) %>%
  summarise(agemean = mean(jage), agemedian = median(jage)
  	       ,agesd = sd(jage)
  	       ,agemin = min(jage), agemax = max(jage))
)

#or
print ( summary(selected_nzes2011$jage) )

# Q. For example, we could consider if those that strongly like NZ First
# are older than those that strongly dislike NZ ? 

## selected over just 2 levels of jnzflike
# jnzflike is not a numerical value
print(
selected_nzes2011 %>% 
  filter(jnzflike %in% c("0","10")) %>%
  group_by(jnzflike) %>% 
  summarise(count = n())
	)

## add a categorical variable based on jage
selected_nzes2011 <- selected_nzes2011 %>% 
  mutate(retiredage = ifelse(jage >= 65, "retired age", "working age"))

print(
	selected_nzes2011 %>% 
  	group_by(retiredage) %>% 
  	summarise(count = n())
)

## adding another columnt to the dataet
selected_nzes2011 <- selected_nzes2011 %>% 
  mutate(numlikenzf = as.numeric(jnzflike))
print   
print(unique(selected_nzes2011$numlikenzf))

## checking if conversion was ok
print(
selected_nzes2011 %>% 
  group_by(jnzflike,numlikenzf) %>% 
  summarise(count=n())
)
#the above shows the problem so  the correct conversion is
selected_nzes2011 <- selected_nzes2011 %>% 
## redo the grouping check
  mutate(numlikenzf = as.numeric(as.character(jnzflike)))
print(
selected_nzes2011 %>% 
  group_by(jnzflike,numlikenzf) %>% 
  summarise(count=n())
)



