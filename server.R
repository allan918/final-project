library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

source("player-stats.R")

server <- function(input, output) {
  
  
  output$stats <- renderUI({
    player <- stats_df %>%
      filter(player_names == input$stat_name)
    str1 <- paste(input$stat_name)
    str2 <- paste(player$X.Position)
    str3 <- paste(player$X.Jersey.Num)
    HTML(paste(str1, str2, str3, sep = "<br/>"))
  })
}

shinyServer(server)