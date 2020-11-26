libraries
install.packages('tidyverse')
install.packages("xml2")
install.packages("rvest")

library(tidyverse)
library(rvest)
library(xml2)

# web page tags
url = "https://www.careerbuilder.com/jobs?pages=n&utf8=%E2%9C%93&keywords=Data+Scientist%2C+data+analyst%2C+statistician&location="
page <- xml2::read_html(url)

# dataframe
listings <- data.frame(Job-title = character(),
                       Job-details = character(), 
                       Date-posted = character(), 
                       descriptions = character(),
                       stringsAsFactors=FALSE) 

#get the job title
Job_Title <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="data-results-title dark-blue-text b"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()


#get job details.
Job_details <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="data-details"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()


#get job date posted 
Date_posted <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="data-results-publish-time"]')  %>% 
  rvest::html_text() %>%
  stringi::stri_trim_both()


#get job description
Job_descriptions <- page %>% 
  rvest::html_nodes("div")  %>% 
  rvest::html_nodes(xpath = '//*[@class="block show-mobile"]')  %>% 
  rvest::html_text() %>%
  str_extract(".+")


# df
listings <- rbind(listings, as.data.frame(cbind(Job_Title,
                                                Job_details,
                                                Date_posted,
                                                descriptions)))

listings

write.csv(listings, "listings.csv")
