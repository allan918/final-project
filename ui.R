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
      "Birthday by State and Team",
      sidebarLayout(
        sidebarPanel(
          # select widget by states
          textInput(
            inputId = "state",
            label = "State Selection",
            choices = list(
              "Illinois" = "IL",
              "Indiana" = "IN",
              "Michigan" = "MI",
              "Ohio" = "OH",
              "Wisconsin" = "WI"
            )
          )
        ),
        mainPanel(
          plotOutput("state")
        )
      )
    ),
    tabPanel(
      
      
    ),
    tabPanel(
      
    )
  )
)
shinyUI(ui)