#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  output$mymap <- renderLeaflet({
    leaflet(data = join_festivals) %>% addTiles() %>%
      addMarkers(~long, ~lat, 
                 popup = ~as.character(paste(sep = "<br/>", name, place, web, start, end)), 
                 label = ~as.character(paste(name)),
                 icon = makeIcon("www/om_icon.png", "www/am_icon.png@2x", 36, 36)) %>% 
      addProviderTiles(providers$Stamen.Toner)
  })
}
