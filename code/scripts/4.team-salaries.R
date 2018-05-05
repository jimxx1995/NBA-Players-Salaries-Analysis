# =========================================================================
# Title: Extract Team salary
# Description:
# Use the TeamSalaries to Extract Team salaries to analyze the mean, median, S.D, etc.
# Generate a new csv for the shiny app.
# Author: Jimmy Chan
# =========================================================================
#source the function
source(file = "code/function/Team-Salaries.R")
#Use the TeamSalaries fucntion to Extract the data
TeamSalaries(team_names)