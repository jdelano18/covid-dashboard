library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Covid-19 Dashboard"),
  dashboardSidebar(
    # sliderInput("size", "Size of Points:", min=0.5, max=5, value=2)
    dateRangeInput("daterange", "Date range:",
                   format = "mm-dd-yyyy",
                   start = "2020-03-16",
                   end = "2020-03-29"),
    
    selectInput("state", "Choose a state:", choices = NULL)
  ),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    # fluidRow(
    #   box(width=10, 
    #       status="info", 
    #       title="Covid Dashboard",
    #       solidHeader = TRUE,
    #       plotOutput("myplot")
    #   )
      # ),
      # box(width=6,
      #     status="warning",
      #     title = "Data Frame",
      #     solidHeader = TRUE,
      #     collapsible = TRUE,
      #     tableOutput("table")
      # )
    # )
    ## Add some more info boxes
    fluidRow(
      valueBoxOutput(width=6, "nhospitalized"),
      valueBoxOutput(width=6, "ncases")
     )
  )
)
