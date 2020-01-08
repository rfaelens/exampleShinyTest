hello <- function() {
  print("Hello, world!")
}

#' Application that displays HelloWorld
#' @return a shiny app
#' @export
helloWorldApp <- function() {
    ui <- shiny::fluidPage(
        shiny::htmlOutput("myOutput")
    )
    server <- function(input, output, session) {
        output$myOutput <- shiny::renderUI({
            hello()
        })
    }
    shiny::shinyApp(ui = ui, server = server)
}
