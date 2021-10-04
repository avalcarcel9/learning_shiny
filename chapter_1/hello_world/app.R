# Chapter 1: Your first Shiny app
# https://mastering-shiny.org/basic-app.html
# 
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# If you’ve already created the app.R file, you can quickly add the app
# boilerplate by typing “shinyapp” and pressing Shift+Tab.

ui <- shiny::fluidPage(
    "Hello, world!"
)
server <- function(input, output, session) {
}
shiny::shinyApp(ui, server)

