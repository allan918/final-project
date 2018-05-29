# Function that plots the
library(dplyr)
library(plotly)
library(RColorBrewer)
build_college_map <- function(team, nba_players, colleges) {
  # To remove the coaches. Which have an age of 0.
  nba_players <- filter(nba_players, X.Age != 0) %>%
    select(X.College, X.Team.Abbr.)
  # Filter more if the user does not wants to see all
  if (team != "all") {
    nba_players <- filter(nba_players, X.Team.Abbr. == team)
  }
  colnames(nba_players) <- c("name", "team")
  # To group by universities and then count the players produced.
  colleges_count <- group_by(nba_players, name) %>%
    summarise(count = n())
  rownames(colleges_count) <- colleges_count$name
  rownames(colleges) <- colleges$name
  # To join the dataframe with the count with the one with the coordinates.
  to_plot <- left_join(colleges_count, colleges)
  to_plot <- to_plot[order(to_plot$name),]
  if (to_plot[1] == "") {
    to_plot <- to_plot[-1, ]
  }
  if (team != "all") {
    marker_size <- 5 * (to_plot$count)
    graph_title <- team
  } else {
    marker_size <- to_plot$count
    graph_title <- "The NBA"
  }

  # Plots The Map using the coordinates, etc.!
  mapped <- plot_ly(
    type = "scattergeo", lon = to_plot$longitude, lat = to_plot$latitude, 
    mode = "markers",
    text = paste0(
      to_plot$name, "</br> Players Produced: ",
      to_plot$count
    ), color = to_plot$count, colors = "Spectral",
    marker = list(size = marker_size)
  ) %>%
    # A lot of fancy specifications.
    layout(geo = list(
      scope = "usa",
      showland = TRUE,
      landcolor = toRGB("grey83"),
      subunitcolor = toRGB("white"),
      countrycolor = toRGB("white"),
      showlakes = TRUE,
      lakecolor = toRGB("lightblue"),
      showsubunits = TRUE,
      showcountries = TRUE,
      resolution = 50,
      lonaxis = list(
        showgrid = TRUE,
        gridwidth = 0.5,
        range = c(-140, -55),
        dtick = 5
      ),
      lataxis = list(
        showgrid = TRUE,
        gridwidth = 0.5,
        range = c(20, 60),
        dtick = 5
      )
    ), title = paste0("Universities Player Production in ", graph_title)
    ) %>%
    colorbar(title = "Quantity of Players Produced")
  return(mapped)
}
