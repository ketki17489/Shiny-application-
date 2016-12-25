# Shiny-application-
An app is created in Shiny package of R, to predict diamond price


## About the app
This app can be used to predict the price of diamonds with respect to carats and cut type of the diamonds. The diamond dataset from ggplot2 package is used here to develope two models models, which predicts the price.

## How to use
-To lauch this app write the following command in r/Rstudio console.

```{r}
install.packages("shiny")
library("shiny")
runGitHub('Shiny-application-','ketki17489')
```

-select carat and cut desired from left side pannel of the app.
-press Submit button.

you will see the predicted price by two models in main pannel.
