library(shiny)
library(ggplot2)
library(plotly)

source("scripts/player-stats.R")

ui <- fluidPage(
  titlePanel("Welcome to our project!"),
  theme = "styles.css",
  h1("2017-2018 NBA Season"),
  tabsetPanel(
    # the first page
    #purpose of project, authors, source of data, intended audience, additional info
    tabPanel(
      "Introduction",
      mainPanel(
        p("By: Xifei Wang, Samuel Valdes, Kcee Landon, Michael Bantle", align = "center"),
        p("Our project shows information about NBA players, filtered by team, in the United States.", 
           "Each tab, respectively, shows a map where players were born by state, a map of the number of",
           "players at each university, and individual statistics in the 2017-2018 NBA season. Our intended audience", 
            "for this project is directed towards curious NBA fans as well as recruiters. We obtained our data from",
            "the 'My Sports Feed' API link below. Enjoy!", align = "center"),
        p("Links: https://www.mysportsfeeds.com/data-feeds/api-docs/#")
      )
    ),
    # the second page
    tabPanel(
      "Player Birth Place by State and Team",
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
        mainPanel(
          plotlyOutput("state_plot"),
          p("The map above selects a list of NBA teams and highlights the number of",
            "professional players by state birthplace in each of the",
          em("50"),
            "states. Looking at the data, the greatest number of NBA players born in an individual",
            "state is",
          strong("California"),
            "with",
          em("72"),
            "players. NBA recruiters can utilize this information to recruit players even earlier",
            "than college, targeting states that currently produce the most NBA prospects.")
        )
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
          plotlyOutput("college_map"),
          p("The map above shows the number of players and their respective university by state.",
            " The university with the greatest number of NBA players produced is",
          strong(""),
            "with",
          em(""),
            "players. The university with the lowest number of NBA players produced is",
          strong(""),
            "with",
          em(""),
            "players. While the NBA is made up of majority former college athletes, it is important",
            "to note that some players did not go to college, such as Lebron James. This information",
            "is incredibly valuable for NBA recruiters who are further able to identify which universities",
            "they want to focus their attention towards")
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
          htmlOutput("stats"),
          p("The information above details a number of statistics on each individual NBA",
            "player, including an image of each",
          em("2017-2018"),
            "athlete. Statistics include each player's first and last name, team, jersey number",
            "position, height, weight, points per game (PPG), fiels goal (FG) percentage, 3-point (3P)",
            "percentage, 2-point (2P) percentage, and free throw (FT) percentage. Most importantly, these",
            "these statistics help us to rank each individual player in the",
          em("2017-2018"),
            "NBA season. The",
          strong("TOP 3"),
            "players ranked this season are",
          strong("")
            )
        )
      )
    )
  )
)

shinyUI(ui)
