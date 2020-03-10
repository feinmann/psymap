#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  output$mymap <- renderLeaflet({
    leaflet(data = join_festivals) %>% addTiles() %>%
      addCircleMarkers(~long, ~lat, 
                 popup = ~as.character(paste(sep = "<br/>", name, place, web, start, end, style, info)),
                 color = "red",
                 layerId = ~name) %>% 
      addProviderTiles(providers$Stamen.Toner) %>% 
      addMeasure(
        primaryLengthUnit = "meters",
        primaryAreaUnit = "sqmeters",
        activeColor = "#3D535D",
        completedColor = "#7D4479"
      )
  })
  
  observe({
    click <- input$mymap_marker_click
    if(is.null(click))
      return(text <- "")
    text <- paste0("You've selected festival '", click$id, "'. Wanna vote?!")
    output$click_text <- renderText({ text })
    
    newEntry <- observe({
      if(input$update > 0) {
        newLine <- isolate(c(input$text1, click$id))
        isolate(values$df <- rbind(values$df, newLine))
      }
    })
    
  })
  
  values <- reactiveValues()
  values$df <- data.frame(Name = character(0), Festival = character(0))
  
  output$table1 <- renderTable({values$df})
  
}
