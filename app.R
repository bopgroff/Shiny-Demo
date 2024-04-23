# load packages –---------------------------------------------------------------

library(tidyverse)
library(shiny)

# load data –-------------------------------------------------------------------

weather <- read_csv("data/weather.csv")

# create app –------------------------------------------------------------------

shinyApp(
  ui = fluidPage(
    titlePanel("Weather Forecasts"),
    sidebarLayout(
      sidebarPanel(
        # UI input code goes here
        selectInput("city","Select a city",
          choices = c("Chicago", "Durham", "Sedona", "New York", "Los Angeles"),
          selected = "Durham"
        ),
          selectInput("stat","Select a stat",
                      choices = c("temp", "feelslike", "humidity"),
                      selected = "temp"
          ),

      ),
      mainPanel(
        # UI output code goes here
        plotOutput("plot")
      )
    )
  ),
  server = function(input, output, session) {

    output$plot <- renderPlot({
      weather |>
        filter(city == input$city)|>
        ggplot(aes_string(x = "time", y = input$stat))+
        geom_line()
    })


    # server code goes here

  }

)