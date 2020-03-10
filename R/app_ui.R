#' @import shiny
#' @import leaflet
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    bootstrapPage(
      tags$head(
        tags$style(type = "text/css", "html, body {width:100%;height:100%}")
      ),
      leafletOutput("mymap", width = "100%", height = "100%"),
      absolutePanel(
        bottom = 30, left = 10, 
        h1("psymap", style="background-color:red"),
        div(h1(textOutput("click_text"), style="background-color:red"))
      ),
      absolutePanel(
        bottom = 30, right = 10, 
        conditionalPanel("typeof(input.mymap_marker_click) === 'object'", 
                         actionButton("update", "Vote!!"),
                         div(textInput("text1", "Name"), style="font-color:red"),
                         tableOutput("table1"))
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'psymap')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
