library(shiny)
library(ggplot2)

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
      "Birthday by State and Team",
      sidebarLayout(
        sidebarPanel(
          # select widget by states
          textInput(
            inputId = "something",
            label = "input something"
          )
        ),
        mainPanel(
        )
      )
    ),
    tabPanel(
      "Map of Colleges"
      
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
          htmlOutput("stats")
        )
      )
    )
  )
)
shinyUI(ui)