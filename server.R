library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
source("player-stats.R")
source("scripts/state-name.R")
source("scripts/college_production.R")
server <- function(input, output) {
  
  simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
  }
  
  output$selected_name <- renderText({
    paste0(simpleCap(input$stat_name))
  })
  
  output$player_image <- renderUI({
    player <- nba_info_df %>%
      filter(tolower(player_names) == tolower(input$stat_name))
    tags$img(src = player$X.Official.Image.URL)
  })
  
  
  output$stats <- renderUI({
    player <- stats_df %>%
      filter(tolower(player_names) == tolower(input$stat_name))
    str1 <- paste0(player$X.Team.City, " ", player$X.Team.Name,
                   " #", player$X.Jersey.Num, " | ", player$X.Position)
    str2 <- paste(player$X.Height, "|", player$X.Weight, "lbs")
    str3 <- paste()
    HTML(paste(str1, str2, sep = "<br/>"))
  })
  # To pass the dataframes to the function
  nba_players <- read.csv("data/nba.csv", stringsAsFactors = F)
  colleges <- read.csv("data/nba_colleges_location.csv",
                       stringsAsFactors = F)
  # Plots the college map
  output$college_map <- renderPlotly({
    build_college_map(input$team_coll, nba_players, colleges)
  })
  players <- reactive({
    player <- read.csv("data/nba.csv", stringsAsFactors = FALSE) %>%
      filter(X.Birth.Country == "USA")
    player$state <- state_name(player$X.Birth.City)
    player$count <- 1
    if(input$team != "all") {
      player <- filter(player, X.Team.Name == input$team)
    }
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
