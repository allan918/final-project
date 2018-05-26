library(shiny)
library(ggplot2)
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
              "Warriors" = "Warrirors",
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
              "Blazers" = "Blazers",
              "Kings" = "Kings",
              "Spurs"= "Spurs",
              "Raptors" = "Raptors",
              "Jazz" = "Jazz",
              "Wizards" = "Wizards"
            )
          )
        ),
        mainPanel(
          plotOutput("state")
        )
      )
    ),
    tabPanel(
      "fhf"
    
    ),
    tabPanel(
      "a"
      
    )
  )
)
shinyUI(ui)