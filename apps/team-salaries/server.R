library(shiny)
library(dplyr)
library(ggplot2)
library(wesanderson)
library(rsconnect)
stats <- read.csv("./Data/team-salaries.csv")

shinyServer(
  function(input,output){
    output$Plot<-renderPlot({
#      setwd('C:/Users/Jim/Desktop/Github/NBAPlayersSalariesAnalysis')
      choice <- input$statistic
      d_or_a <- input$order
      if(d_or_a == "Descending order"){
        ggplot(stats, aes(x=reorder(stats$Team,stats[,choice]), y=stats[,choice],fill=reorder(stats$Team,stats[,choice]))) + ggtitle("Horizontal Bar-Chart of selected team statistics") +
        geom_bar(stat = "identity") + labs(x="Team",y="Dollar") + coord_flip()+ theme(legend.title=element_blank())+scale_y_continuous(labels = scales::dollar)
        }else{
        ggplot(stats, aes(x=reorder(stats$Team,-stats[,choice]), y=stats[,choice],fill=reorder(stats$Team,stats[,choice]))) + ggtitle("Horizontal Bar-Chart of selected team statistics") +
          geom_bar(stat = "identity") + labs(x="Team",y="Dollar") + coord_flip()+ theme(legend.title=element_blank())+scale_y_continuous(labels = scales::dollar)
      }
    })
  }
)