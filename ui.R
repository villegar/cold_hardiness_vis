#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
# Define UI for application that draws a histogram
shiny::shinyUI(shiny::fluidPage(

  # Application title
  shiny::titlePanel("Cold Hardiness Visualiser"),

  # Sidebar with a slider input for number of bins
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::selectInput(
        inputId = "station",
        label = "Weather station",
        choices = newa_stations$station_state
      ),

      shiny::dateInput(
        inputId = "dates",
        label = "Start date:",
        max = Sys.time()
      ),
    ),


    # Show a plot of the generated distribution
    shiny::mainPanel(
      shiny::tableOutput("dailyData")
    )
  )
))
