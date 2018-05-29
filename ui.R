library(shiny)
library(ggplot2)
library(plotly)

source("scripts/player-stats.R")

ui <- fluidPage(
  #theme = "styles.css",
  h1("NBA"),
  tabsetPanel(
    # the first page
    tabPanel(
      "Introduction"
    ),
    # the second page
    tabPanel(
      "Birth place by State and Team",
      sidebarLayout(
        sidebarPanel(
          # select widget by states
          selectInput(
            inputId = "team",
            label = "Select a team",
            choices = list(
              "All" = "all",
              "Atlanta Hawks" = "Hawks",
              "Boston Celtics" = "Celtics",
              "Brooklyn Nets" = "Nets",
              "Charlotte Hornets" = "Hornets",
              "Chicago Bulls" = "Bulls",
              "Cleveland Cavaliers" = "Cavaliers",
              "Dallas Mavericks" = "Mavericks",
              "Denver Nuggets" = "Nuggets",
              "Detroit Pistons" = "Pistons",
              "Golden State Warriors" = "Warriors",
              "Houston Rockets" = "Rockets",
              "Indiana Pacers" = "Pacers",
              "Los AngelesClippers" = "Clippers",
              "Los Angeles Lakers" = "Lakers",
              "Memphis Grizzlies" = "Grizzlies",
              "Miami Heat" = "Heat",
              "Milwaukee Bucks" = "Bucks",
              "Minnesota Timberwolves" = "Timberwolves",
              "New Orleans Pelicans" = "Pelicans",
              "New York Knicks" = "Knicks",
              "Oklahoma City Thunder" = "Thunder",
              "Orlando Magic" = "Magic",
              "Philadelphia 76ers" = "76ers",
              "Phoenix Suns" = "Suns",
              "Portland Trail Blazers" = "Trail Blazers",
              "Sacramento Kings" = "Kings",
              "San Antonio Spurs" = "Spurs",
              "Toronto Raptors" = "Raptors",
              "Utah Jazz" = "Jazz",
              "Washington Wizards" = "Wizards"
            )
          )
        ),
        mainPanel(plotlyOutput("state_plot"))
      )
    ),
    tabPanel(
      "Map of Colleges",
      sidebarLayout(
        sidebarPanel(
          # select for team
          selectInput(
            inputId = "team_coll",
            label = "Select a team",
            choices = list(
              "All" = "all",
              "Atlanta Hawks" = "ATL",
              "Boston Celtics" = "BOS",
              "Brooklyn Nets" = "BRO",
              "Charlotte Hornets" = "CHA",
              "Chicago Bulls" = "CHI",
              "Cleveland Cavaliers" = "CLE",
              "Dallas Mavericks" = "DAL",
              "Denver Nuggets" = "DEN",
              "Detroit Pistons" = "DET",
              "Golden State Warriors" = "GSW",
              "Houston Rockets" = "HOU",
              "Indiana Pacers" = "IND",
              "Los Angeles Clippers" = "LAC",
              "Los Angeles Lakers" = "LAL",
              "Memphis Grizzlies" = "MEM",
              "Miami Heat" = "MIA",
              "Milwaukee Bucks" = "MIL",
              "Minnesota Timberwolves" = "MIN",
              "New Orleans Pelicans" = "NOP",
              "New York Knicks" = "NYK",
              "Oklahoma City Thunder" = "OKC",
              "Orlando Magic" = "ORL",
              "Philadelphia 76ers" = "PHI",
              "Phoenix Suns" = "PHX",
              "Portland Trail Blazers" = "POR",
              "Sacramento Kings" = "SAC",
              "San Antonio Spurs" = "SAS",
              "Toronto Raptors" = "TOR",
              "Utah Jazz" = "UTA",
              "Washington Wizards" = "WAS"
            )
          )
        ),
        mainPanel(
          plotlyOutput("college_map")
        )
      )
    ),
    # player stats
    tabPanel(
      "Active Player Statistics",
      sidebarLayout(
        sidebarPanel(
          textInput(
            inputId = "stat_first_name",
            label = "Type in a Player's First Name",
            value = nba_info_df$X.FirstName
          ),
          textInput(
            inputId = "stat_last_name",
            label = "Type in a Player's Last Name",
            value = nba_info_df$X.LastName
          )
        ),
        mainPanel(
          textOutput("selected_name"),
          uiOutput("player_image"),
          htmlOutput("stats")
        )
      )
    )
  )
)

shinyUI(ui)
