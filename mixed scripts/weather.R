library(Stat2Data)
library(dplyr)
library(ggplot2)
library(tidyverse)
library(crayon)

#Importing data
df <- read.csv("weather_data.csv")
head(df, n=2)

#summary statistics 
summary(df)

#Removing Duplicates rows
dim(df)
df1<-distinct(df)
dim(df1)

#checking for null values
table(is.na(df1))
sapply(df1, function(x) sum(is.na(x)))
newdata <- na.omit(df1)

dim(newdata)

#Analysis 1: Relationship between Humidity and Dew Point
df1 %>%
  group_by(humid, dewp)%>%
  summarise(dew =mean(dewp, na.rm = TRUE))%>%
  ggplot() + aes(humid, dewp, color=dewp) + geom_point() +
  geom_jitter() + 
  xlab('Humidity') +
  ylab('Dew point') +
  ggtitle("Relationship between Humidity and Dew Point")



