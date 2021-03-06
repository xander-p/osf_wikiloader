## ----setup, include=FALSE---------------------------------------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----imports----------------------------------------------------------------------------------------------------------------------------------------------------------------
library(httr)
library(stringi)
library(jsonlite)
library(rlist)
library(data.table)
library(commonmark)


## ----access-----------------------------------------------------------------------------------------------------------------------------------------------------------------
#insert here your token to access the records. Go to https://osf.io/settings/tokens/ and create one, but keep it confidential.
apiKey <- "" #insert it here
#access your project's (or its component's) wikis. Define the project's code below. You can find it in the address bar here: https://osf.io/project_code/, when you are on the page of your project, or its component.
project_code <- "" #insert it here


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
osf_wikiloader <- function(apiKey, project_code){
  project_url <- paste0("https://api.osf.io/v2/nodes/", project_code, "/wikis/")
  
  wikis <- GET(project_url,
    add_headers(Authorization = paste("Bearer", apiKey)))

  jsonResponseParsed <- fromJSON(content(wikis, as="text"))

  wikis_list <- as.list(jsonResponseParsed$data$id)
  counter = 0
  for (id in wikis_list){
    
    func_url = paste0("https://api.osf.io/v2/wikis/", id, "/versions/")
    getversion = GET(func_url,
    add_headers(Authorization = paste("Bearer", apiKey)))
    version = fromJSON(content(getversion, as = "text"))
    content_url = paste0("https://api.osf.io/v2/wikis/", id, "/versions/", version$data$id[1],"/content/")
    content = GET(content_url, add_headers(Authorization = paste("Bearer", apiKey)))
    filename = paste0("wiki_", chartr(":","_",version$data$attributes$date_created[[1]]), ".html")
    a <- markdown_html(content, hardbreaks = TRUE, smart = TRUE, normalize = TRUE, sourcepos = TRUE, extensions = FALSE)
    write(a, filename)
    counter = counter + 1
    }
  print(paste("Complete; the function retrieved", counter, "wiki entries for project", project_code, "and attempted to save it .html files."))
}


## ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
osf_wikiloader(apiKey, project_code)

