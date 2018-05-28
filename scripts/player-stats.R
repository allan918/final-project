library(dplyr)

# player stats

stats_df <- read.csv(file = "data/points_data.csv", stringsAsFactors = FALSE)

stats_df <- stats_df[-c(387), ]

nba_info_df <- read.csv(file = "data/nba.csv", stringsAsFactors = FALSE)

nba_info_df <- nba_info_df %>%
  filter(X.Team.Abbr. != "")

player_names <- paste(stats_df$X.FirstName, stats_df$X.LastName)

stats_df$player_names <- player_names

nba_info_df$player_names <- player_names

stats_df$ppg <- round((stats_df$X.FtMade + 2 * stats_df$X.Fg2PtMade
                       + 3 * stats_df$X.Fg3PtMade) / stats_df$X.GamesPlayed, 2)

three_pct <- paste0(round(stats_df$X.Fg3PtMade / stats_df$X.Fg3PtAtt * 100, 2), "%")

stats_df$three_pct <- replace(three_pct, three_pct == "NaN%", "0%")

two_pct <- paste0(round(stats_df$X.Fg2PtMade / stats_df$X.Fg2PtAtt * 100, 2), "%")

stats_df$two_pct <- replace(two_pct, two_pct == "NaN%", "0%")

ft_pct <- paste0(round(stats_df$X.FtMade / stats_df$X.FtAtt * 100, 2), "%")

stats_df$ft_pct <- replace(ft_pct, ft_pct == "NaN%", "0%")

