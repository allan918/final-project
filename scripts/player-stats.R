library(dplyr)

# player stats

stats_df <- read.csv(file = "../data/points_data.csv", stringsAsFactors = FALSE)

player_names <- paste(stats_df$X.FirstName, stats_df$X.LastName)

