library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(DT)

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
  simple_cap <- function(x) {
    s <- strsplit(x, " ")[[1]]
    paste(toupper(substring(s, 1, 1)), substring(s, 2),
      sep = "", collapse = " "
    )
  }

  # displays the name of inputted player
  output$selected_name <- renderText({
    simple_cap(paste(input$stat_first_name, input$stat_last_name))
  })

  # displays the player picture
  output$player_image <- renderUI({
    player <- nba_info_df %>%
      filter(
        tolower(X.FirstName) == tolower(input$stat_first_name),
        tolower(X.LastName) == tolower(input$stat_last_name)
      )
    if (!tolower(paste(input$stat_first_name, input$stat_last_name)) %in%
        tolower(stats_with_wins$player_names)) {
      HTML(paste("Please enter a valid player"))
    } else if (player$X.Official.Image.URL != "Not Available") {
      tags$img(src = player$X.Official.Image.URL)
    } else {
      HTML(paste("Image not Available"))
    }
  })

  # data table of stats
  output$stats_table <- renderDT({
    validate(need(tolower(paste(input$stat_first_name,
                                input$stat_last_name)) %in%
                    tolower(stats_with_wins$player_names), message = F))
    player <- stats_with_wins %>%
      filter(
        tolower(X.FirstName) == tolower(input$stat_first_name),
        tolower(X.LastName) == tolower(input$stat_last_name)
      )
    player <- player[c(5:6, 15, 26:29, 31, 33:34)]
    names(player) <- c(
      "Jersey #", "Position", "Team",
      "PPG", "3P%", "2P%", "FT%", "FG%", "Rating", "Rank")
    datatable(player, caption = "2017-18 NBA Regular Season Statistics",
              rownames = T, filter = "top",
              options = list(
                pageLength = 1, sDom  = '<"top">rt'
              )) %>%
      formatStyle(c(
        "Jersey #", "Position", "Team",
        "PPG", "3P%", "2P%", "FT%", "FG%", "Rating", "Rank"),
        backgroundColor = "gray")
  })
  # Plots the college map
  output$college_map <- renderPlotly({
    build_college_map(input$team_coll, nba_players, colleges, input$size)
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
        color = ~ sum, colors = "Set3"
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
