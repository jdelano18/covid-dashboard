library(shiny)
library(shinydashboard)
library(ggplot2)
library(readr)
library(tidyverse)

shinyServer(function(input, output, session) {
  
  mydata <- reactiveFileReader(
    intervalMillis = 8.64e+7, 
    session = session,
    filePath = 'https://covidtracking.com/data/download/all-states-history.csv',
    readFunc = read_csv)
  
  observeEvent(input$state, {
    updateSelectInput(session, "state", choices = sort(unique(mydata()$state)))
  }, once = TRUE)
  
  observeEvent(input$daterange, {
    range <- sort(unique(mydata()$date))
    updateDateRangeInput(session, "daterange", start = head(range, n=1), end = tail(range, n=1), 
                         min = head(range, n=1), max = tail(range, n=1))
  }, once = TRUE)
  

  df <- reactiveFileReader(
          intervalMillis = 8.64e+7,
          session = session,
          filePath = './data/mydata.csv',
          readFunc = read_csv)
  

  output$nhospitalized <- renderValueBox({
    results <- mydata() %>% 
      filter((state == input$state) &
               (date >= as.Date(input$daterange[1])) &
               (date <= as.Date(input$daterange[2]))) 
    
    # NOTE: some states just fill all hospitalizedIncrease with 0
    # replace with NA
    value2 <- ifelse(sum(results$hospitalizedIncrease) == 0, 
                     "NA", 
                     results %>% summarise(hospitalized = sum(hospitalizedIncrease)))
    
    valueBox(value = value2,
             subtitle = "Number Hospitalized",
             icon = icon("procedures"),
             color = "red")

  })

  output$ncases <- renderValueBox({
    results <- mydata() %>% filter((state == input$state) &
                                     (date >= as.Date(input$daterange[1])) &
                                     (date <= as.Date(input$daterange[2]))) %>% summarise(cases = sum(positiveIncrease))
    valueBox(value = results$cases, 
             subtitle = "Number of Cases",
             icon = icon("chart-line"))
  })

})
