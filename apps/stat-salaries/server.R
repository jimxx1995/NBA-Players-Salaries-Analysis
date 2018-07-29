library(shiny)
library(ggplot2)
stats<-read.csv('./data/eff-salary-stats.csv')
#stats<-read.csv('eff-salary-stats.csv')
desc=c('Name of the Player','Points','Total Rebounds',"Assists","Steals","Blocks","Missed Field Goals",
"Missed Free Throws","Turnovers", "Games","Efficiency Statistic- An index that takes into account some other
valuable statistics(Please see the final report for details)","Salary of the Player", "Basketball positions.")

var_desc <- data.frame(row.names = colnames(stats), 'Desc'=desc)
shinyServer(
  function(input, output){
    output$Plot<-renderPlot({
      xvar<-input$x_var
      yvar<-input$y_var
      if(input$color=="Yes"){
        ggplot()+ggtitle("Scatter Plot of selected statistics")+
        geom_point(data=stats, aes(stats[,xvar], stats[,yvar], color=stats$position), size=2)+
        labs(x=xvar,y=yvar)+scale_color_discrete("Player Position") 
      }else{
        ggplot()+ggtitle("Scatter Plot of selected statistics")+
        geom_point(data=stats, aes(stats[,xvar], stats[,yvar]), size=2)+
        labs(x=xvar,y=yvar)
      }
    })
    output$Text<-renderText({
      xvar<-input$x_var
      yvar<-input$y_var
      paste("The correlation coefficient between the chosen variables is: ",cor(stats[,xvar],stats[,yvar]))
    })

    output$Text2 <- renderText({
     "\nVariables Description:"
    })
    output$Text3 <- renderText({
      xvar<-input$x_var
      x_desc<-paste(input$x_var,'-',var_desc[xvar,])
      paste(x_desc)
    })
    output$Text4 <- renderText({
      yvar<-input$y_var
      y_desc<-paste(input$y_var,'-',var_desc[yvar,])
      paste(y_desc)
    })
  }
)

