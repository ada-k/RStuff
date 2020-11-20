# installing and loading necessary libraries
install.packages("tidyverse")
install.packages("funModeling")
install.packages("Hmisc")

library(tidyverse) 
library(Hmisc)
library(funModeling)

# loading dataset
data = state.x77

# EDA
# basic data information (descriptive stats)
first_exploration <- function(data)
{
  glimpse(data)
  print(status(data))
  print(profiling_num(data))
  summary(data)
}

first_exploration(data)

# bivariate analysis
plot(Murder~Income, data= data,
     main="Murder vs Per Capita State Income Scatter Plot", xlab ="Per Capita State Income", ylab = "Murders per 100 Thousand")
# scatter plots
ggplot(data = data) +  geom_point(mapping = aes(x = Population, y = Income)) + ggtitle("Population against Income Scatter plot")
ggplot(data = data) +  geom_point(mapping = aes(x = Life Exp, y = Murder)) + ggtitle("Life Exp against Murder Scatter plot")

# correlation 
res = cor(data) 
res

# plotting correlation
install.packages("corrplot")
library(corrplot)
corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)
