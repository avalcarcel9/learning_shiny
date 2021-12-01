#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  
  fluidRow(
    column(6, 
           plotOutput("l_distPlot")
    ),
    column(6, 
           plotOutput("r_distPlot")
    )
  ),
  fluidRow(
    column(6, 
           sliderInput("l_bins",
                       "Left Number of bins:",
                       min = 1,
                       max = 50,
                       value = 30)
    ),
    column(6, 
           sliderInput("r_bins",
                       "Right Number of bins:",
                       min = 1,
                       max = 50,
                       value = 30)
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$l_distPlot <- renderPlot({
    # generate bins based on input$l_bins from ui.R
    # draw the histogram with the specified number of bins
    ggplot(faithful, aes(eruptions)) +
      geom_histogram(bins = input$l_bins)
  })
  
  output$r_distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    # draw the histogram with the specified number of bins
    ggplot(faithful, aes(eruptions)) +
      geom_freqpoly(bins = input$r_bins)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
