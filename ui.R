library(shiny)
library(ggplot2)
shinyUI(fluidPage(
  titlePanel("Predict price of diamond from carats and cut"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("sliderCarat", "What is the desired carat", 0.2000, 5.0100, value = 0.7000),
      selectInput("dropDownCut", "Choose you Input:", choices = unique(diamonds$cut)),
      
      submitButton("Submit")
    ),
    mainPanel(
      
      h3("Predicted Price from Model 1:"),
      textOutput("pred1"),
      h3("Predicted Price from Model 2:"),
      textOutput("pred2")
    )
  )
))