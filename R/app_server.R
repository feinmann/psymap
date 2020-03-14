#' @import shiny
#' @import rdrop2
app_server <- function(input, output, session) {
  
  data <- loadData() %>% unique() %>% reactiveVal()
  init_data <- isolate(data())
  
  onStop(function() {
    if (isolate(input$vote_button > 0)) {
      save_data <- isolate(data())
      saveData(save_data)
    }
  })
  
  # List the first level callModules here
  output$mymap <- renderLeaflet({
    leaflet(data = join_festivals) %>% addTiles() %>%
      addCircleMarkers(~long, ~lat, 
                 popup = ~as.character(paste(sep = "<br/>", name, place, web, start, end, style, info)),
                 color = "red",
                 layerId = ~name) %>% 
      addProviderTiles(providers$Stamen.Toner) %>% 
      addMeasure(
        position = "topright",
        primaryLengthUnit = "meters",
        primaryAreaUnit = "sqmeters",
        activeColor = "#3D535D",
        completedColor = "#7D4479"
      ) %>% 
      htmlwidgets::onRender("
                     function(el, x) {
               this.on('popupopen', function(e) {
               Shiny.onInputChange('myEvent', 'open');
               });
               
               this.on('popupclose', function(e) {
               Shiny.onInputChange('myEvent', 'close');
               });
            }")
  })
  
  observe({
    click <- input$mymap_marker_click
    if(is.null(click))
      return()
    text <- paste0("You've selected festival '", click$id, "'. Wanna vote?!")
    output$click_text <- renderText({ text })
    

    })
    
  observeEvent(input$vote_button, {
    click <- input$mymap_marker_click
    if(is.null(click))
      return()
    newLine <- isolate(data.table::data.table(name = input$text1, festival = click$id))
    isolate(data(data.table::rbindlist(list(data(), newLine))))
  })
  
  output$infoText <- renderText({
    print(str(input$mymap_marker_click))
  })
  
  observe({
    click <- input$mymap_click
    if(is.null(click))
      return()
    text <- ""
    output$click_text <- renderText({ text })
    
  })
  
  output$table1 <- renderTable({data()})
  
}
