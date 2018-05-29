library(dplyr)

# player stats

stats_df <- read.csv(file = "data/points_data.csv", stringsAsFactors = F)

stats_df <- stats_df[!(stats_df$X.Age == 0),]

nba_info_df <- read.csv(file = "data/nba.csv", stringsAsFactors = F)

nba_info_df <- nba_info_df %>%
  filter(X.Team.Abbr. != "")

nba_info_df <- nba_info_df[!(nba_info_df$X.Age == 0),]

team_df <- read.csv(file = "data/teamstandings.csv", stringsAsFactors = F)

player_names <- paste(stats_df$X.FirstName, stats_df$X.LastName)

stats_df$player_names <- player_names

stats_df$ppg <- round((stats_df$X.FtMade + 2 * stats_df$X.Fg2PtMade
                       + 3 * stats_df$X.Fg3PtMade) / stats_df$X.GamesPlayed, 2)

three_pct <- paste0(round(stats_df$X.Fg3PtMade / stats_df$X.Fg3PtAtt * 100, 2), "%")

stats_df$three_pct <- replace(three_pct, three_pct == "NaN%", "0%")

two_pct <- paste0(round(stats_df$X.Fg2PtMade / stats_df$X.Fg2PtAtt * 100, 2), "%")

stats_df$two_pct <- replace(two_pct, two_pct == "NaN%", "0%")

ft_pct <- paste0(round(stats_df$X.FtMade / stats_df$X.FtAtt * 100, 2), "%")

stats_df$ft_pct <- replace(ft_pct, ft_pct == "NaN%", "0%")

stats_df$total_points <- stats_df$X.Fg2PtMade * 2 + stats_df$X.Fg3PtMade * 3 +
  stats_df$X.FtMade

wins <- team_df$X.Wins

X.Team.Abbr. <- team_df$X.Team.Abbr.

team_and_wins_df <- data.frame(X.Team.Abbr., wins, stringsAsFactors = F)

stats_with_wins <- left_join(stats_df, team_and_wins_df)

league_avg <- sum(stats_with_wins$total_points) / nrow(stats_with_wins)

win_avg <- sum(team_df$X.Wins) / nrow(team_df)

games_played_avg <- sum(stats_with_wins$X.GamesPlayed) / nrow(stats_with_wins)

# ranking system with weights
stats_with_wins$player_score <- stats_with_wins$total_points / league_avg  +
  stats_with_wins$wins / win_avg + stats_with_wins$X.GamesPlayed / games_played_avg

stats_with_wins <- stats_with_wins %>%
  arrange(-player_score) %>%
  mutate(player_rank = c(1:573)) %>%
  arrange(X.LastName)

stats_with_wins[is.na(stats_with_wins)] <- "Not Available"

# filtering out the coaches
stats_with_wins <- stats_with_wins[!(stats_with_wins$X.Age == 0),]

# filtering out those who did not play a game
stats_with_wins <- stats_with_wins[!(stats_with_wins$X.GamesPlayed == 0),]

