# =========================================================================
# Title: Scrape raw html tables
# Description:
# This script use the Scrape-Data-Function to scrape the tables 
# 'Roster', 'Totals', and 'Salaries', for a specific NBA team.
# Each table is read as a data.frame, which is then exported as a csv file
# to the corresponding subdirectory in the 'rawdata/' folder
# author: Jimmy Chan
# =========================================================================
#load package
library(XML)
# source  functions
source(file = "code/functions/Scrape-Data-Function.R")
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
#run ScrapeData function 
ScrapeData(team_names)