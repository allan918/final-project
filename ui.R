library(shiny)
library(ggplot2)
library(plotly)
source("scripts/player-stats.R")
ui <- fluidPage(
  theme = "styles.css",
  h1("2017-2018 NBA Season"),
  tabsetPanel(
    # the first page
    #purpose of project, authors, source of data,
    #intended audience, additional info
    tabPanel(
      "Introduction",
      mainPanel(
        p("By: Xifei Wang, Samuel Valdes, Kcee Landon, Michael Bantle",
          align = "center"),
        p("Our project shows information about NBA players,
          filtered by team, in the United States.",
           "Each tab, respectively, shows a map where players
          were born by state, a map of the number of",
           "players at each university, and individual
          statistics in the 2017-2018 NBA season.
          Our intended audience",
            "for this project is directed towards
          curious NBA fans as well as recruiters. We obtained our data from",
            "the following",
          tags$a(href = "https://www.mysportsfeeds.com/data-feeds/api-docs/#",
                 " link."), align = "center"),
        p("Our team chose this website because of all the data it
          provides, including current season statistics, previous season's
          statistics, playoff reports, box scores, and more. While there are
          4 professional sports to choose from (NFL, NBA, MLB, NHL), our
          group decided to focus our attention towards the NBA because we
          are all big basketball fans, and the 2017-2018 season playoffs are
          going on right now!"),
        
        p("Below our questions that we are going to answer through this
          project:"),
        
        p("Question 1 - How many professional basketball players were born in",
          "each state? Filter by team."),
        
        p("Question 2 - What is the rank of each NBA player? Who are the top 3",
          "2017-2018 NBA players?"),
          
        p("Question 3 - How many players in the NBA attended each college?",
          "Filter by team.")
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
          p("The map above selects a list of NBA teams
            and highlights the number of",
            "professional players by state birthplace in each of the",
          em("50"),
            "states. Looking at the data, the greatest number of
          NBA players born in an individual",
            "state is",
          strong("California"),
            "with",
          em("72"),
            "players. NBA recruiters can utilize
          this information to recruit players even earlier",
            "than college,
          targeting states that currently produce the most NBA prospects.
          For an interested fan, one can see similarities in where they
          were born and see if there are any similarities to their
          favorite team!")
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
          ),
          sliderInput("size", label = "Size of Points",
                      min = 1, max = 10, value = 1)
        ),
        mainPanel(
          plotlyOutput("college_map"),
          p("The map above shows the number of players
            and their respective university by state.",
            " The university with the greatest number
            of NBA players produced is",
          strong(""),
            "with",
          em(""),
            "players. While the NBA is made up of primarily
          former college athletes, it is important",
            "to note that some players did not go to college,
          such as Lebron James. This information",
            "is incredibly valuable for NBA recruiters who
          are further able to identify which universities",
            "they want to focus their attention towards.
          Additionally, we find it important to note that
          the Southeastern region of the United States
          has the most concentrated NBA prospects. While
          it is hard to know the cause, a correlation
          could be because the Southeast has the greatest
          black population per capita. Finally, we can
          turn our attention towards the University of
          Washington, which looks like an outlier located in
          the Northwestern region of the United States. A
          reason for a high concentration of NBA athletes
          at this university could be because of the most
          recent coach at the University, Lorenzo Romar, who
          is known for recruiting top NBA prospects and
          therefore good players attract towards the school.")
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
          p("The information above details a number
            of statistics on each individual NBA",
            "player, including an image of each",
          em("2017-2018"),
            "athlete. Statistics include each player's
          first and last name, team, jersey number",
            "position, height, weight, points per game (PPG),
          fiels goal (FG) percentage, 3-point (3P)",
            "percentage, 2-point (2P) percentage, and free
          throw (FT) percentage. Most importantly, these",
            "these statistics help us to rank each
          individual player in the",
          em("2017-2018"),
            "NBA season. The",
          strong("TOP 3"),
            "players ranked this season are",
          strong(top_three()), ". It is important to note
          that there are biases in these rankings. We
          derived our ranking system by individual points
          per game, three point shooting percentage, two
          point shooting percentage, and free throw
          percentage."
            )
        )
      )
    )
  )
)


shinyUI(ui)
