library(shiny)
library(dplyr)
library(ggplot2)
shinyServer(
  function(input,output){
    output$Plot<-renderPlot({
      setwd('C:/Users/Alvin/Desktop/project')
      stats <- read.csv('data/cleandata/team-salaries.csv')
      choice <- input$statistic
      d_or_a <- input$order
      if(d_or_a == "Descending order"){
        ggplot(stats, aes(x=reorder(stats$Team,stats[,choice]), y=stats[,choice])) + ggtitle("Horizontal Bar-Chart of selected team statistics") +
          geom_bar(stat = "identity") + labs(x="Team",y="Dollar") + coord_flip()
        }else{
        ggplot(stats, aes(x=reorder(stats$Team,-stats[,choice]), y=stats[,choice])) + ggtitle("Horizontal Bar-Chart of selected team statistics") +
          geom_bar(stat = "identity") + labs(x="Team",y="Dollar") + coord_flip()
      }
    })
  }
)