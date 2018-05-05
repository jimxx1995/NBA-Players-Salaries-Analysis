shinyUI(fluidPage(
  titlePanel(title="Relationship between all the player statistics"),
  sidebarLayout(
    sidebarPanel(
      selectInput("y_var", "y-variable", 
                  choices = list("PTS", "TRB", "AST", "STL", "BLK", "MFG",
                                 "MFT", "TOV", "G", "EFF", "salaries"), selected = "salaries"),
      selectInput("x_var", "x-variable", 
                  choices = list("PTS", "TRB", "AST", "STL", "BLK", "MFG",
                                 "MFT", "TOV", "G", "EFF", "salaries")),
      radioButtons("color", "Colored by position",
                   choices = list("Yes", "No"), 
                   selected = "Yes")
    ),
    mainPanel(
      plotOutput("Plot"),
      textOutput("Text"),
      textOutput("Correlation")
    )
  )
)
)