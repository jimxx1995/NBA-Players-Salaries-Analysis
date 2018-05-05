# =========================================================================
# Title: Scrape raw function
# Description:
# This function scrapes 'Roster', 'Totals', and 'Salaries', for a specific NBA team.
# Each table is read as a data.frame, which is then exported as a csv file
# to the corresponding subdirectory in the 'rawdata/' folder
# Author: Jimmy Chan
# =========================================================================
ScrapeData <- function(team_hrefs) { 
  n <- length(team_hrefs)
  basketref <- 'http://www.basketball-reference.com'
  team_names <- substr(team_hrefs, 8, 10)
  #use the loop to scrape the data
  for (i in 1:n) {
    # Read html document (as a character vector) for a given team
    url_team <- paste0(basketref, team_hrefs[i])
    html_doc <- readLines(con = url_team)
    
    # initial line position of roster html table	
    begin_roster <- grep('id="roster"', html_doc)
    # find the line where the html ends
    line_counter <- begin_roster
    while (!grepl("</table>", html_doc[line_counter])) {
      line_counter <- line_counter + 1
    }
    # read roster table as data.frame and export it as csv
    roster <- readHTMLTable(html_doc[begin_roster:line_counter])
    write.csv(roster,
              file = paste0('rawdata/roster-data/roster-', team_names[i], '.csv'))
              
	# initial line position of totals html table		 
    begin_totals <- grep('id="totals"', html_doc)
    # find the line where the html ends
    line_counter <- begin_totals
    while (!grepl("</table>", html_doc[line_counter])) {
      line_counter <- line_counter + 1
    }
    # read totals table as data.frame and export it as csv
    totals <- readHTMLTable(html_doc[begin_totals:line_counter])
    write.csv(totals,
              file = paste0('rawdata/stat-data/stats-', team_names[i], '.csv'))
    
    # initial line position of salaries html table
    begin_salaries <- grep('id="salaries"', html_doc)
    # find the line where the html ends
    line_counter <- begin_salaries
    while (!grepl("</table>", html_doc[line_counter])) {
      line_counter <- line_counter + 1
    }
    # read salaries table as data.frame and export it as csv
    salaries <- readHTMLTable(html_doc[begin_salaries:line_counter])
    write.csv(salaries,
              file = paste0('C:/Users/Jim/Desktop/final project/rawdata/salary-data/salaries-', team_names[i], '.csv'))
    
  }
}