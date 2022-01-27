#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# library(shiny)
`%>%` <- magrittr::`%>%`

newa_stations <- scrappy::newa_stations %>%
  dplyr::mutate(station_state = stringr::str_c(name,
                                               " [",
                                               stringr::str_squish(state),
                                               "]"))

# Define server logic required to draw a histogram
shiny::shinyServer(function(input, output) {
    output$dailyData <- shiny::renderTable({
      Sys.sleep(1)
      # browser()
      tryCatch({
        aux <- scrappy::newa_nrcc3(year = lubridate::year(input$dates),
                                   month = lubridate::month(input$dates),
                                   day = lubridate::day(input$dates),
                                   hour = 0,
                                   station = input$station)
        dplyr::bind_rows(
          aux$daily,
          aux$daily_forecast
        ) %>%
          dplyr::distinct()
      }, error = function(e) {
      })
    })
})
