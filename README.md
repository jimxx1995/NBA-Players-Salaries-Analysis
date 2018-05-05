# Stat 133 Final Project

The final project analyzes the data about basketball players from the National Basketball
Association (NBA) League in the 2015-2016 season.The central topic is analyzing the salary 
and performance of NBA players.The motivating question is: ¡§In the 2015-2016 season, how 
do the skills of a player relate to his salary?¡¨ In this project, we use all the concepts,
skills, and ideas covered in the course, such as, data acquisition, data cleaning, data  
analysis.


## Software

```
*[R](https://www.r-project.org/)
*[R Studio](https://www.rstudio.com/)

```

## File Structure

```
project/
  README.md
  code/
    functions/
        ...
    scripts/
        download-data-script.R
        clean-data-script.R
        eda-script.R
        compute-efficiency-script.R
   data/
        rawdata/
            roster-data/
                ...
            salary-data/
                ...
            stat-data/
                ...
            cleandata/
         roster-salary-stats.csv
         eff-stats-salary.csv
         eda-output.txt
   images/
      ...
   apps/
        team-salaries/
            ui.R
            server.R
        stat-salaries/
            ui.R
            server.R
    report/
        report.Rmd
        report.pdf
    slides/
        slides.Rmd
        slides.html
```

##Data Acquisition
We wrote a function in R to scrape the `Roster`, `Totals`, and `Salaries` for each team 
and store the raw data files in folders `roster-data/`, `stat-data/`, and `salary-data/`


##Data Cleaning

We wrote a data cleaning function in R to produce the`roster-salary-stats.csv` that contains all variables from 
`Roster`, `Totals`, and `Salary` and removes the useless contents. Then, we stored the 
`roster-salary-stats.csv` in `cleandata` folder.

##Analysis

####Exploratory Data Analysis

We wrote an exploratory data analysis function `eda` to calculate descriptive summaries for quantitative
variables. We stored those results to a text file `eda-output.txt` in the fodler `cleandata`, and used a shiny
app that displays a horizontal bar-chart.

####Performance of players
We used the Principal Components Analysis (PCA) to compute a weight for each term in the original EFF formula and
created a new table `eff-salary-stats.csv` in the directory `cleandata`. We used shiny app to visualize the 
relationship between all the player statistics and display a scatterplot in which the x-axis corresponds to one 
statistic, and the y-axis corresponds to salary.


## Authors

* **Jimmy Chan** 
* **Cho Fung Chan**
* **Justin Lau**
* **Anthony Dela Paz**

## License

This project is licensed under the [MIT License](https://opensource.org/licenses/MIT)
