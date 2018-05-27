library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
source("player-stats.R")
state_name <- function(input) {
  substr(input, nchar(input) - 1, nchar(input))
}
server <- function(input, output) {
  output$stats <- renderUI({
    player <- stats_df %>%
      filter(player_names == input$stat_name)
    str1 <- paste(input$stat_name)
    str2 <- paste(player$X.Position)
    str3 <- paste(player$X.Jersey.Num)
    HTML(paste(str1, str2, str3, sep = "<br/>"))
  })
  players <- reactive({
    player <- read.csv("data/nba.csv", stringsAsFactors = FALSE) %>%
      filter(X.Birth.Country == "USA")
    player$state <- state_name(player$X.Birth.City)
    player$count <- 1
    player <- filter(player, X.Team.Name == input$team)
    play_group <- group_by(player, state) %>%
      summarise(sum = sum(count))
    play_group
  })
  output$state_plot <- renderPlotly({
    g <- list(
      scope = "usa",
      projection = list(type = "albers usa"),
      showlakes = TRUE,
      lakecolor = toRGB("white")
    )
    p <- plot_geo(players(), locationmode = "USA-states") %>%
      add_trace(
        z = ~ sum, locations = ~ state,
        color = ~ sum, colors = "Purples"
      ) %>%
      colorbar(title = "Players") %>%
      layout(
        title = "Counts of the NBA player by state",
        geo = g
      )
    p
  })
}

shinyServer(server)
