# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

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
    shiny::shinyApp(ui=ui, server=server)
}
