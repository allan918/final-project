library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)

source("player-stats.R")
source("scripts/college_production.R")

server <- function(input, output) {
  
  simpleCap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
          sep = "", collapse = " ")
  }
  
  output$selected_name <- renderText({
    simpleCap(paste(input$stat_first_name, input$stat_last_name))
  })
  
  # displays the player picture
  output$player_image <- renderUI({
    player <- nba_info_df %>%
      filter(tolower(X.FirstName) == tolower(input$stat_first_name),
             tolower(X.LastName) == tolower(input$stat_last_name))
    tags$img(src = player$X.Official.Image.URL)
  })
  
  # display of player stats
  output$stats <- renderUI({
    player <- stats_df %>%
      filter(tolower(X.FirstName) == tolower(input$stat_first_name),
             tolower(X.LastName) == tolower(input$stat_last_name))
    if (tolower(paste(input$stat_first_name, input$stat_last_name))
        %in% tolower(nba_info_df$player_names)) {
      str1 <- paste0(player$X.Team.City, " ", player$X.Team.Name,
                   " #", player$X.Jersey.Num, " | ", player$X.Position)
      str2 <- paste(player$X.Height, "|", player$X.Weight, "lbs")
      str3 <- paste("PPG:", player$ppg, "|", "3P%:", player$three_pct,
                  "|", "2P%:", player$two_pct, "|", "FT%:", player$ft_pct)
      HTML(paste(str1, str2, str3, sep = "<br/>"))
    } else {
      HTML(paste("Please Input a Valid Active Player"))
    }
  })
  
  # To pass the dataframes to the function
  nba_players <- read.csv("data/nba.csv", stringsAsFactors = F)
  colleges <- read.csv("data/nba_colleges_location.csv",
                       stringsAsFactors = F)
  # Plots the college map
  output$college_map <- renderPlotly({
    build_college_map(input$team_coll, nba_players, colleges)
  })
}

shinyServer(server)