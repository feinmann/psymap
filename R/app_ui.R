#' @import shiny
#' @import leaflet
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    bootstrapPage(
      tags$head(
        tags$style(type = "text/css", "html, body {width:100%;height:100%}",
        HTML('
             #absolute_panel {background-color: rgba(255,0,0,1.0);
                              outline-color: rgba(0,0,0,1.0);}
             ')
      )),
      leafletOutput("mymap", width = "100%", height = "100%"),
      absolutePanel(
        bottom = 30, left = 10, 
        h1("psymap", style="background-color:red"),
        div(h1(textOutput("click_text"), style="background-color:red"))
      ),
      conditionalPanel("input.myEvent == 'open'", 
                       helpText("Please enter your name and",
                                "vote for the festival of your life!")),
      absolutePanel(id = "absolute_panel",
        top = 50, right = 10, 
        conditionalPanel("input.myEvent == 'open' && input.vote_button === 0", 
                         helpText("Please enter your name and vote for the festival of your life!"),
                         actionButton("vote_button", "Vote!!"),
                         div(textInput("text1", "Name"), style="font-color:red")),
        conditionalPanel("input.vote_button > 0",
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
