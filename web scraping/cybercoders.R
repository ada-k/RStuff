# libraries
install.packages('tidyverse')
install.packages("xml2")
install.packages("rvest")

library(tidyverse)
library(rvest)
library(xml2)

# web page tags
url = "https://www.cybercoders.com/search/?page=n&searchterms=data+scientist%2C+data+analyst%2C+statistician&searchlocation=&newsearch=true&originalsearch=true&sorttype="
page <- xml2::read_html(url)

# dataframe
listings <- data.frame(Title= character(),
                       location = character(), 
                       posted= character(), 
                       descriptions = character(),
                       wage = character(),
                       skills = character(),
                       stringsAsFactors=FALSE) 

#get the job title
Title <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="job-title"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()


#get job location
location <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="location"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()

#get job salary
wage <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="wage"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()


#get job time posted 
posted <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="posted"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()

#get job skills
skills <- page %>% 
  rvest::html_nodes("ul")  %>% 
  rvest::html_nodes(xpath = '//*[@class="skill-list"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()
  

#get job description
descriptions <- page %>% 
rvest::html_nodes("div")  %>% 
rvest::html_nodes(xpath = '//*[@class="description"]')  %>% 
rvest::html_text() %>%
str_extract(".+")


# df
listings <- rbind(listings, as.data.frame(cbind(Title,
                                                location,
                                                posted,
                                                wage,
                                                skills,
                                                descriptions)))

listings

setwd("C:/Users/lotomej/Desktop/Gigs")
write.csv(listings, "cybercoders.csv")
