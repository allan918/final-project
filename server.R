library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
source("scripts/player-stats.R")
source("scripts/state-name.R")
source("scripts/college_production.R")
# To pass the dataframes to the function
nba_players <- read.csv("data/nba.csv", stringsAsFactors = F)
colleges <- read.csv("data/nba_colleges_location.csv",
  stringsAsFactors = F
)
server <- function(input, output) {

  
  # function to capitalize first letter of each word
  simple_Cap <- function(x) {

    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
      sep = "", collapse = " "
    )
  }

  
  # displays the name of inputted player


  output$selected_name <- renderText({
    simple_Cap(paste(input$stat_first_name, input$stat_last_name))
  })
  # displays the player picture
  output$player_image <- renderUI({
    player <- nba_info_df %>%
      filter(
        tolower(X.FirstName) == tolower(input$stat_first_name),
        tolower(X.LastName) == tolower(input$stat_last_name)
      )
    tags$img(src = player$X.Official.Image.URL)
  })
  # display of player stats
  output$stats <- renderUI({

    player <- stats_with_wins %>%
      filter(tolower(X.FirstName) == tolower(input$stat_first_name),
             tolower(X.LastName) == tolower(input$stat_last_name))
    if (tolower(paste(input$stat_first_name, input$stat_last_name))
        %in% tolower(stats_df$player_names)) {
      str1 <- paste0(player$X.Team.City, " ", player$X.Team.Name,
                   " #", player$X.Jersey.Num, " | ", player$X.Position)
      str2 <- paste(player$X.Height, "|", player$X.Weight, "lbs")
      str3 <- paste("PPG:", player$ppg, "|", "3P%:", player$three_pct,
                  "|", "2P%:", player$two_pct, "|", "FT%:", player$ft_pct)
      str4 <- paste("Our Rating:", round(player$player_score, 3), "|", "Player Rank:", player$player_rank)
      HTML(paste(str1, str2, str3, str4, sep = "<br/>"))
    } else {
      HTML(paste("Please Input a Valid Active Player"))
    }
  })
  # Plots the college map
  output$college_map <- renderPlotly({
    build_college_map(input$team_coll, nba_players, colleges)
  })

  

  # filter out the dataframe that we need

  players <- reactive({
    player <- nba_players %>%
      filter(X.Birth.Country == "USA")
    player$state <- state_name(player$X.Birth.City)
    player$count <- 1
    if (input$team != "all") {
      player <- filter(player, X.Team.Name == input$team)
    }
    play_group <- group_by(player, state) %>%
      summarise(sum = sum(count))
    play_group
  })

  

  # draw the state plot

  output$state_plot <- renderPlotly({
    setting <- list(
      scope = "usa",
      projection = list(type = "albers usa"),
      showlakes = TRUE,
      lakecolor = toRGB("white")
    )
    player_state <- plot_geo(players(), locationmode = "USA-states") %>%
      add_trace(
        z = ~ sum, locations = ~ state,
        color = ~ sum, colors = "Purples"
      ) %>%
      colorbar(title = "Players") %>%
      layout(
        title = "Counts of the NBA player by state",
        geo = setting
      )
    player_state
  })
}
  
shinyServer(server)
