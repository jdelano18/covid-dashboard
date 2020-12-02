library(shiny)
library(shinydashboard)

dashboardPage(
  dashboardHeader(title = "Covid-19 Dashboard"),
  dashboardSidebar(
    # sliderInput("size", "Size of Points:", min=0.5, max=5, value=2)
    dateRangeInput("daterange", "Date range:",
                   format = "mm-dd-yyyy",
                   start = NULL,
                   end = NULL),
    
    selectInput("state", "Choose a state:", choices = NULL)
  ),
  dashboardBody(
    fluidRow(
      valueBoxOutput(width=6, "nhospitalized"),
      valueBoxOutput(width=6, "ncases")
     )
  )
)
