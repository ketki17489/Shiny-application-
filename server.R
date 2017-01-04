library(shiny)
library(ggplot2)


server <- function(input, output) {
  
  model1 <- lm(price ~ carat+cut+color+clarity, data = diamonds)

  su<-summary(model1)
  output$acc<-renderText({
    
    su$adj.r.squared * 100
  })
  
  model1pred <- reactive({
    caratInput <- input$sliderCarat
    predict(model1, newdata = 
              data.frame(carat = caratInput,
                         cut = input$dropDownCut,color=input$dropDownColor,
                         clarity=input$dropDownClarity))
  })
  
  output$pred1 <- renderText({
    model1pred()
  })
  output$instructions <- renderUI(HTML("<ul><li><b>Price</b>: price in US dollars ($ 326-$ 18,823).</li>
                                 <li><b>Carat</b>: weight of the diamond (0.2-5.01)</li>
                                 <li><b>Cut</b>: quality of the cut (Fair, Good, Very Good, Premium, 
Ideal)</li>
                                 <li><b>Color</b>: diamond colour, from J (worst) to D (best)</li>
                                 <li><b>Clarity</b>: a measurement of how clear the diamond is 
                                 (I1 (worst), SI1, SI2, VS1, VS2, VVS1, VVS2, IF (best))</li>
                                 </ul> 
                                       <i>For more information go to documentation</i>"))
  
  
  output$doc1<-renderUI(HTML("This app can be used to predict the price of diamonds with 
respect to carats, cut, colour and clarity preferences. 
The diamond dataset from ggplot2 package is used here to develope multiple regression model, 
which predicts the price.

The R file of the app can be studied <a href=https://github.com/ketki17489/Shiny-application->here</a>
<br>

<b>How to use app</b>

<ol><li>select carats, cut, colour and clarity desired from left side pannel of the app.</li>
<li>press Submit button.</li></ol>
you will see the predicted price in main pannel.

For more information Diamond dataset click <a href=http://docs.ggplot2.org/0.9.3.1/diamonds.html>here</a>
                             "))
  
   
   dataset <- reactive({
    diamonds[sample(nrow(diamonds), input$sampleSize),]
  })
  
    output$plot <- renderPlot({
    
    p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
    
    if (input$color != 'None')
      p <- p + aes_string(color=input$color)
    
    facets <- paste(input$facet_row, '~', input$facet_col)
    if (facets != '. ~ .')
      p <- p + facet_grid(facets)
    
    if (input$jitter)
      p <- p + geom_jitter()
    if (input$smooth)
      p <- p + geom_smooth()
    
    print(p)
    
  }, height=700)
}
