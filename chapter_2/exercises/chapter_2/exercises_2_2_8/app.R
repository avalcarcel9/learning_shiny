#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    # https://mastering-shiny.org/basic-ui.html#exercises-1
    titlePanel("Exercises"),
    
    # 2.2.8 Exercises
    # 1. Text input
    textInput(inputId = "name_text", label = "What is your name?", value = "", placeholder = "Your name"),
    
    # 2. Date slider
    sliderInput(inputId = 'dates', label = "Date slider:", value = Sys.Date(), min = as.Date("2021-10-01"), max = as.Date("2021-10-30")),
    
    # 3. Moving slider
    sliderInput(inputId = 'moving', label = "Moving slider:", value = 50, min = 0, max = 100, step = 5, animate = TRUE),
    
    # 4. Long list
    selectInput("state", "Choose a state:",
                list(`East Coast` = list("NY", "NJ", "CT"),
                     `West Coast` = list("WA", "OR", "CA"),
                     `Midwest` = list("MN", "WI", "IA"))
    ),
    textOutput("result")
    
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$result <- renderText({
        paste("You chose", input$state)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
