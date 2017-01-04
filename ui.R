library(shiny)
library(shinydashboard)
library(ggplot2)
dataset <- diamonds

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Documentation", tabName = "doc", icon = icon("diamond")),
      menuItem("Explore Diamond Dataset", tabName = "docEx", icon = icon("diamond"))
    )
  ),
  dashboardBody(
    
    
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
              h2("Diamond Price Prediction"),
              fluidRow(
                 box(
                   title = "Controls",width = 6,
                   sliderInput("sliderCarat", "Select Weight (Carat)", 0.2000, 5.0100, 
                               value = 0.7000),
                   selectInput("dropDownCut", "Choose Cut Quality:", 
                               choices = unique(diamonds$cut)),
                   selectInput("dropDownColor", "Choose Colour:", 
                               choices = unique(diamonds$color)),
                   selectInput("dropDownClarity", "Choose Clarity:", 
                               choices = unique(diamonds$clarity)),
                   submitButton("Submit")
                 ),
                 box(title = "Results",
                   h3("Predicted Price for Diamond(US $):"),
                   textOutput("pred1"),
                   h3("Accuracy of Prediction(%):"),
                   textOutput("acc")
                 )
              ),
              fluidRow(
                uiOutput("instructions")
              )
      ),
      
      # Second tab content
      tabItem(tabName = "doc",h2("About the App"),
              uiOutput("doc1")
      ),
      # Third tab content
      tabItem(tabName = "docEx",
              h2("Explore Diamond Dataset"),
              fluidRow(
                       box(
                         title = "Controls",width = 6,
                         sliderInput('sampleSize', 'Sample Size', min=1, max=nrow(dataset),
                                     value=min(1000, nrow(dataset)), step=500, round=0),
                         
                         selectInput('x', 'X', names(dataset)),
                         selectInput('y', 'Y', names(dataset), names(dataset)[[2]]),
                         selectInput('color', 'Color', c('None', names(dataset))),
                         
                         checkboxInput('jitter', 'Jitter'),
                         checkboxInput('smooth', 'Smooth'),
                         
                         selectInput('facet_row', 'Facet Row', c(None='.', names(dataset))),
                         selectInput('facet_col', 'Facet Column', c(None='.', names(dataset))),
                         submitButton("Submit")
                       ),
                       box(
                         plotOutput('plot')
                       )
                )
                
                
              )
      )
    )
  )
  
