# =========================================================================
# Title: Extract Team salary
# Description:
# Extract Team salaries to analyze the mean, median, S.D, etc.
# Generate a new csv for the shiny app.
# Author: Jimmy Chan
# =========================================================================

TeamSalaries  <- function(team_names) {
  n <- length(team_names)
  NewTable <- data.frame()
  OutputTable <- data.frame()
  NewTable <- data.frame(
    "TotalPayroll" = 1:30 ,
    "MinSalary" = 1:30 ,
    "MaxSalary" = 1:30,
    "MedianSalary" = 1:30 ,
    "FQSalary" =  1:30,
    "TQSalary" = 1:30,
    "AverageSalary" = 1:30,
    "IQRSalary" = 1:30,
    "SD" = 1:30
  )
  NewTable$Team <- team_names
  for (i in 1:n) {
    Salary <- c()
    #import the raw salary dataset
    Salary <- read.csv(file = paste0('data/rawdata/salary-data/salaries-', team_names[i], '.csv'))
    #extract the salaries to integers
    q <- length(Salary[, 4])
    Salary$Salaries <- c()
    for (q in 1:q) {
      Salary$Salaries[q] <- destring(Salary[q, 4], keep = "0-9.-")
    }
    #Get the sum, min, max... to a new data set
    NewTable$TotalPayroll[i] <- sum(Salary$Salaries)
    NewTable$MinSalary[i] <- min(Salary$Salaries)
    NewTable$MaxSalary[i] <- max(Salary$Salaries)
    NewTable$MedianSalary[i] <- median(Salary$Salaries)
    NewTable$FQSalary[i] <- quantile(Salary$Salaries, 0.25)
    NewTable$TQSalary[i] <- quantile(Salary$Salaries, 0.75)
    NewTable$AverageSalary[i] <- mean(Salary$Salaries)
    NewTable$IQRSalary[i] <- IQR(Salary$Salaries)
    NewTable$SD[i] <- sd(Salary$Salaries)
  }
  #New dataset
  write.csv(NewTable, file = paste0('data/cleandata/team-salaries.csv'))
  
}
