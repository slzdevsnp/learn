---
title: "Exploring the BRFSS data"
output: 
  html_document: 
    fig_height: 4
    highlight: pygments
    theme: spacelab
---

## Setup

### Load packages


```r
library(ggplot2)
```

```
## Warning: package 'ggplot2' was built under R version 3.3.1
```

```r
library(dplyr)
```

```
## Warning: package 'dplyr' was built under R version 3.3.1
```

### Load data


```r
load("brfss2013.RData")
```



* * *

## Part 1: Data
"Describe how the observations in the sample are collected, and the implications of this data collection method on the scope of inference (generalizability / causality)""

The BRFSS collects data using both landline and cellular telephone-based surveys. Participants are adults who live in a household (for landline calls) or private residence or college housing (for cell telephone). Only includes the non-institutionalized adult population, aged 18 years or older, who reside in the US. In 2013, additional question sets were included as optional modules to provide a measure for several childhood health and wellness indicators, including asthma prevalence for people aged 17 years or younger.

Given this population that must have access to a phone and have a residence, the indigent population without a stable living situation, those without the means to access a phone will not be surveyed in this data set. The methods do not describe time of day for the phone calls, which has bearing on those working ability to respond to the survey. There is no discussion of the duration of the survey and complexity of the questions asked. As such, while a significant portion of the population will be respresented in this sample, they will not be generalizable to the population overall. This in particular is important for metrics such as alcohol and drug addiction, which may track with those without access to a phone or stable living situation, thereby under-estimating the actual prevalence of important behaviors.  

Finally, given that measures of routine preventative health are being measured (vaccination, exercise, tobacco use), these again are measures that are disproportionately low in the lower income sample that may be missed with this approach to survey (via telephones). Finally, given that most of the data is being subjectively reported (particularly with vaccination history and co-morbid conditions), it is subject to recall bias.

* * *

## Part 2: Research questions

**Research quesion 1:**Does veteran status impact general health status?

**Research quesion 2:**Does average alcohol consumption over past 30 days more than 1 indicate less than excellent health?

**Research quesion 3:**Do men who are veterans have a higher proportion of poor health compared to non-veteran men?


* * *

## Part 3: Exploratory data analysis

NOTE: Insert code chunks as needed by clicking on the "Insert a new code chunk" 
button (green button with orange arrow) above. Make sure that your code is visible
in the project you submit. Delete this note when before you submit your work.

**Research quesion 1:**
Compare general health proportion >good in non-veterans to veterans. First we generated a count of the number of veterans and non-veterans grouped by general health (scaled excellent to poor on the survey) using the piping function. We then took the sum of good to excellent divided by the total number of respondents to generate proportions. We chose good to excellent as a measure of general health as it distinguishes poor and fair (no description to characterize the difference in these categories). From the totals, we made variables (vetcountgood, non_vetcountgood, vetcounttotal, non_vetcounttotal) to plug into the proportion test which were drawn from the tables of veterans counts based on general health score.

```r
 brfss2013 %>% filter(veteran3 == "Yes") %>% group_by(genhlth) %>% summarise(count = n())
```

```
## # A tibble: 6 x 2
##     genhlth count
##      <fctr> <int>
## 1 Excellent  9345
## 2 Very good 18543
## 3      Good 19888
## 4      Fair  9334
## 5      Poor  4065
## 6        NA   271
```


```r
brfss2013 %>% filter(veteran3 == "No") %>% group_by(genhlth) %>% summarise(count = n())
```

```
## # A tibble: 6 x 2
##     genhlth  count
##      <fctr>  <int>
## 1 Excellent  76004
## 2 Very good 140348
## 3      Good 130408
## 4      Fair  57297
## 5      Poor  23833
## 6        NA   1693
```















