library(shiny)
library(ggplot2)
shinyServer(
  function(input, output){
    output$Plot<-renderPlot({
      setwd('C:/Users/Alvin/Desktop/project')
      xvar<-input$x_var
      yvar<-input$y_var
      stats<-read.csv('data/cleandata/eff-salary-stats.csv')
      if(input$color=="Yes"){
        ggplot()+ggtitle("Scatter Plot of selected statistics")+labs(x=xvar,y=yvar)+
        geom_point(data=stats, aes(stats[,xvar], stats[,yvar], color=stats$position), size=2)
      }else{
        ggplot()+ggtitle("Scatter Plot of selected statistics")+labs(x=xvar,y=yvar)+
          geom_point(data=stats, aes(stats[,xvar], stats[,yvar]), size=2)
      }
    })
    output$Text<-renderText({
      "The correlation coefficient between the chosen variables is:" 
    })
    output$Correlation<-renderText({
      setwd('C:/Users/Alvin/Desktop/project')
      xvar<-input$x_var
      yvar<-input$y_var
      stats<-read.csv('data/cleandata/eff-salary-stats.csv')
      cor(stats[,xvar],stats[,yvar])
    })
  }
)

