#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  output$mymap <- renderLeaflet({
    leaflet(data = join_festivals) %>% addTiles() %>%
      addCircleMarkers(~long, ~lat, 
                 popup = ~as.character(paste(sep = "<br/>", name, place, web, start, end, style, info)),
                 color = "red") %>% 
      addProviderTiles(providers$Stamen.Toner) %>% 
      addMeasure(
        primaryLengthUnit = "meters",
        primaryAreaUnit = "sqmeters",
        activeColor = "#3D535D",
        completedColor = "#7D4479"
      )
  })
}
