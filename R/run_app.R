#' Run the Shiny Application
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(...) {
  with_golem_options(
    app = shinyApp(ui = app_ui, 
                   server = app_server, 
                   onStart = function() {
      cat("Doing application setup\n")
      
      onStop(function() {
        cat("Doing application cleanup\n")
      })
    }), 
    golem_opts = list(...)
  )
}
