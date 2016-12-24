library(shiny)
library(ggplot2)
shinyServer(function(input, output) {
  
  model1 <- lm(price ~ carat, data = diamonds)
  model2 <- lm(price ~ carat + cut, data = diamonds)
  
  model1pred <- reactive({
    caratInput <- input$sliderCarat
    predict(model1, newdata = data.frame(carat = caratInput))
  })
  
  model2pred <- reactive({
    caratInput <- input$sliderCarat
    predict(model2, newdata = 
              data.frame(carat = caratInput,
                         cut = input$dropDownCut))
  })
  
  
  output$pred1 <- renderText({
    model1pred()
  })
  
  output$pred2 <- renderText({
    model2pred()
  })
})