#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

ui <- shiny::fluidPage(
    shiny::selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
    shiny::verbatimTextOutput("summary"),
    shiny::tableOutput("table")
)

# Duplicated getting data
# server <- function(input, output, session) {
#     output$summary <- shiny::renderPrint({
#         dataset <- get(input$dataset, "package:datasets")
#         summary(dataset)
#     })
#     
#     output$table <- shiny::renderTable({
#         dataset <- get(input$dataset, "package:datasets")
#         dataset
#     })
# }

# Uses react to get data
server <- function(input, output, session) {
    # Create a reactive expression
    dataset <- reactive({
        get(input$dataset, "package:datasets")
    })
    
    output$summary <- renderPrint({
        # Use a reactive expression by calling it like a function
        summary(dataset())
    })
    
    output$table <- renderTable({
        dataset()
    })
}

shiny::shinyApp(ui, server)