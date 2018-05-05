# =========================================================================
# Title: Cleaning Function
# Description:
# This function combine and clean the 'Roster', 'Totals', and 'Salaries', and generate a new dataset  
# Each table is read as a data.frame, which is then exported as a csv file
# Author: Jimmy Chan
# =========================================================================


Cleaning  <- function(team_names) { 
n <- length(team_names)
NewTable<- c()
#import the Roster dataset
   for(i in 1:n) {
    Roster <- read.csv(file = paste0('data/rawdata/roster-data/roster-', team_names[i], '.csv'))
    #add team names
    Roster$Team <- team_names[i]
     Roster$height <- c()
     #use the loop change to perform height in inches
     k <- length(Roster$roster.Ht)
        for (k in 1:k) {
          x <- strsplit(as.character(Roster$roster.Ht[k]), "-")
          y<-as.numeric(x[[1]][1])
          z<-as.numeric(x[[1]][2])
          Roster$height[k] <- y*12 + z
        }
     #extract the useful columns
     Roster <- Roster[, c(3, 4, 6, 11, 12)]
     Roster <- setNames(Roster, c("player", "position", "weight", "Team", 'height'))
     
     #import the Salary dataset
     Salary <- read.csv(file = paste0('data/rawdata/salary-data/salaries-', team_names[i], '.csv'))
     #extract the useful columns
     Salary <- Salary[, c(3, 4)]
     Salary <- setNames(Salary, c("player", "salaries"))
     #change the salaries to integers
     Salary$salaries<- destring(Salary$salaries, keep="0-9.-") 
     
     #import the Salary dataset
     Stats <-  read.csv(file = paste0('C:/Users/Jim/Desktop/final project/rawdata/stat-data/stats-', team_names[i], '.csv'))
     #extract the useful columns
     Stats <- Stats[, c(3, 5, 8, 9, 18, 19, 23, 24, 25, 26, 27, 28, 29)]
     Stats <- setNames(Stats,
              c("player", "G", "FG", "FGA", "FT", "FTA", "TRB", "AST", "STL", "BLK", "TOV", "PF", "PTS"))
     Table<- c()
     #combine all the tables
     Table <- join_all(list(Roster, Salary, Stats), by = 'player', type = 'full')
     NewTable <-rbind(NewTable,Table)
   } 

#reorder the column
NewTable<- NewTable[ ,c(1,6,2,5,3,7,8,9,10,11,12,13,14,15,16,17,18,4)]

#delete row contains 'NA'
NewTable<-na.omit(NewTable)

#delete repeated row
NewTable <-NewTable[!duplicated(NewTable$player),]

#Choose rows contains C/PF/PG/SF/SG
NewTable<-filter(NewTable, grepl("C|PF|PG|SF|SG",position))

write.csv(NewTable, file = paste0('data/rawdata/roster-salary-stats.csv'))

} 
