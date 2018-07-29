options(encoding ='UTF-8')

shinyUI(fluidPage(
  titlePanel(title="Team Statistics"),
  sidebarLayout(
    sidebarPanel(
      selectInput("statistic", "What stastistic to be displayed", 
                  choices = list("TotalPayroll", "MinSalary", "MaxSalary", "MedianSalary", "FQSalary", 
                                 "TQSalary", "AverageSalary", "IQRSalary", "SD")),

      radioButtons("order", "How should the bars be displayed?",
                   choices = list("Descending order", "Ascending order"), 
                   selected = "Descending order")
    ),
    mainPanel(
      plotOutput("Plot")
    )
  )
)
)