#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(reactable)

# 2. 
# ui <- fluidPage(
#   plotOutput("plot", width = "400px")
# )
# server <- function(input, output, session) {
#   output$plot <- renderPlot(plot(1:5), 
#                             res = 96, 
#                             width = 300,
#                             height = 700)
# }

# # 3.
# ui <- fluidPage(
#   dataTableOutput("table")
# )
# server <- function(input, output, session) {
#   output$table <- renderDataTable(mtcars, options = list(pageLength = 5, searching = FALSE))
# }

# 4.
ui <- fluidPage(
  reactableOutput("table")
)
server <- function(input, output) {
  output$table <- renderReactable({
    reactable(mtcars)
  })
}
# Run the application 
shinyApp(ui = ui, server = server)
