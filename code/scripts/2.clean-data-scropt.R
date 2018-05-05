# =========================================================================
# Title: Clean Raw Data Scripts

# Description:
# This script uses the Cleaning function to clean tables 
# 'Roster', 'Totals', and 'Salaries', to generate a new data set
# Each table is read as a data.frame, which is then exported as a csv file
# Author: Jimmy Chan
# =========================================================================
#load packages
packages<-c('rvest','plyr','pipeR', 'knitr','XML','readr','stringr','taRifx')
lapply(packages, library, character.only = TRUE)

# source  functions
source(file = "code/functions/Cleaning-Function.R")
# base url
basketref <- 'http://www.basketball-reference.com'
#parse 'http://www.basketball-reference.com/leagues/NBA_2016.html'
url <- paste0(basketref, '/leagues/NBA_2016.html')
doc <- htmlParse(url)
# identify nodes with anchor tags for each team and
# extract the href attribute from the anchor tags
team_rows <- getNodeSet(doc, "//th[@scope='row']/a")
team_hrefs <- xmlSApply(team_rows, xmlAttrs)
#use unique function to delete the duplicated team names 
team_hrefs<-unique(team_hrefs)
#extract the team names
team_names <- substr(team_hrefs, 8, 10)
#use unique function to delete the duplicated team names 
team_names<-unique(team_names)
#run Cleaning function 
Cleaning(team_names)