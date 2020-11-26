page_result_start <- 10 # starting page 
page_result_end <- 110 # last page results
page_results <- seq(from = page_result_start, to = page_result_end, by = 10)

full_df <- data.frame()

d <- data.frame(job_title=character(),
                       job_location=character(), 
                       company_name=character(), 
                       summary = character(),
                       links = character(),
                       job_description = character(),
                       stringsAsFactors=FALSE)

for(i in seq_along(page_results)) {
  
  first_page_url <- "https://www.indeed.com/jobs?q=data+scientist%2C+data+analyst%2C+statistician"
  url <- paste0(first_page_url, "&start=", page_results[i])
  page <- xml2::read_html(url)
  # Sys.sleep pauses R for two seconds before it resumes
  # Putting it there avoids error messages such as "Error in open.connection(con, "rb") : Timeout was reached"
  Sys.sleep(2)
  
  #get the job title
  job_title <- page %>% 
    rvest::html_nodes("div") %>%
    rvest::html_nodes(xpath = '//a[@data-tn-element = "jobTitle"]') %>%
    rvest::html_attr("title")
  
  # get job location
  job_location = page %>% 
    rvest::html_nodes(".location") %>%
    rvest::html_text()
  
  #get the company name
  company_name <- page %>% 
    rvest::html_nodes("span")  %>% 
    rvest::html_nodes(xpath = '//*[@class="company"]')  %>% 
    rvest::html_text() %>%
    stringi::stri_trim_both() -> company.name 
  
  # summary
  summary = page %>%
    rvest::html_nodes('#resultsCol .summary') %>%
    rvest::html_text() %>%
    str_extract(".+")
  
  # get links
  links <- page %>% 
    rvest::html_nodes("div") %>%
    rvest::html_nodes(xpath = '//*[@data-tn-element="jobTitle"]') %>%
    rvest::html_attr("href")
  
  # job description
  job_description <- c()
  for(i in seq_along(links)) {
    
    url <- paste0("https://ca.indeed.com", links[i])
    page <- xml2::read_html(url)
    
    job_description[[i]] <- page %>%
      rvest::html_nodes("span")  %>% 
      rvest::html_nodes(xpath = '//*[@class="jobsearch-JobComponent-description icl-u-xs-mt--md"]') %>% 
      rvest::html_text() %>%
      stringi::stri_trim_both()
  }
  
  
  # dataframe
  d <- rbind(d, as.data.frame(cbind(job_title, job_location, company_name, summary, links, job_description)))
  d

  #df <- data.frame(job_title, company_name, job_location, summary, links, job_description)
  #full_df <- rbind(full_df, df)
  #full_df
  
}

install.packages("data.table")
library(data.table)

fwrite(d, file ="listings.csv")


### analysis

# dimension
nrow(d)
ncol(d)
dim(d)
length(d)

# location popularity
library(dplyr)
dplyr::count(d, job_location, sort = TRUE)

# company popularity
dplyr::count(d, company_name, sort = TRUE)

# job popularity
dplyr::count(d, job_title, sort = TRUE)
