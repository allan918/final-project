library(shiny)
library(ggplot2)
library(plotly)

source("player-stats.R")

ui <- fluidPage(
  theme = "styles.css",
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
            label = "Which team do u want to view?",
            choices = list(
              "Hawks" = "Hawks",
              "Celtics" = "Celtics",
              "Nets" = "Nets",
              "Hornets" = "Hornets",
              "Bulls" = "Bulls",
              "Cavaliers" = "Cavaliers",
              "Mavericks" = "Mavericks",
              "Nuggets" = "Nuggets",
              "Pistons" = "Pistons",
              "Warriors" = "Warriors",
              "Rockets" = "Rockets",
              "Pacers" = "Pacers",
              "Clippers" = "Clippers",
              "Lakers" = "Lakers",
              "Grizzlies" = "Grizzlies",
              "Heat" = "Heat",
              "Bucks" = "Bucks",
              "Timberwolves" = "Timberwolves",
              "Pelicans" = "Pelicans",
              "Knicks" = "Knicks",
              "Thunder" = "Thunder",
              "Magic" = "Magic",
              "76ers" = "76ers",
              "Suns" = "Suns",
              "Trail Blazers" = "Trail Blazers",
              "Kings" = "Kings",
              "Spurs" = "Spurs",
              "Raptors" = "Raptors",
              "Jazz" = "Jazz",
              "Wizards" = "Wizards"
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
            choices = list("All" = "all",
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
              "San Antonio Spurs"= "SAS",
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
            inputId = "stat_name",
            label = "Type in a Player Name",
            value = player_names
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
