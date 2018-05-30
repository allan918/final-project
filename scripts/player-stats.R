library(dplyr)

# player stats

# statistics data frame for points statistics and games played
stats_df <- read.csv(file = "data/points_data.csv", stringsAsFactors = F)

# filtering out coaches
stats_df <- stats_df[!(stats_df$X.Age == 0), ]

# data frame that holds image urls
nba_info_df <- read.csv(file = "data/nba.csv", stringsAsFactors = F)

# filtering out those with no team
nba_info_df <- nba_info_df %>%
  filter(X.Team.Abbr. != "")

# filtering out coaches
nba_info_df <- nba_info_df[!(nba_info_df$X.Age == 0), ]

# adding "Not Available" to non existent image urls
nba_info_df$X.Official.Image.URL <-
  replace(
    nba_info_df$X.Official.Image.URL, nba_info_df$X.Official.Image.URL == "",
    "Not Available"
    )

# data frame with statistics about wins and losses for each team
team_df <- read.csv(file = "data/teamstandings.csv", stringsAsFactors = F)

# full names of players
player_names <- paste(stats_df$X.FirstName, stats_df$X.LastName)

stats_df$player_names <- player_names

# equation for points per game of each player
stats_df$ppg <- round(
  (stats_df$X.FtMade + 2 * stats_df$X.Fg2PtMade
                       + 3 * stats_df$X.Fg3PtMade) / stats_df$X.GamesPlayed, 2)

# equation for three point shooting percentage
three_pct <- paste0(
  round(stats_df$X.Fg3PtMade / stats_df$X.Fg3PtAtt * 100, 2), "%"
  )

# replacing "NaN" values with 0%
stats_df$three_pct <- replace(three_pct, three_pct == "NaN%", "0%")

# equation for two point shooting percentage
two_pct <- paste0(
  round(stats_df$X.Fg2PtMade / stats_df$X.Fg2PtAtt * 100, 2), "%"
  )

# replacing "NaN" values with 0%
stats_df$two_pct <- replace(two_pct, two_pct == "NaN%", "0%")

# equation for free throw percentage
ft_pct <- paste0(round(stats_df$X.FtMade / stats_df$X.FtAtt * 100, 2), "%")

# replacing "NaN" values with 0%
stats_df$ft_pct <- replace(ft_pct, ft_pct == "NaN%", "0%")

# equation for finding the total points for each player
stats_df$total_points <- stats_df$X.Fg2PtMade * 2 + stats_df$X.Fg3PtMade * 3 +
  stats_df$X.FtMade

# total field goal percentage (includes three pointers and two pointers)
stats_df$fg_pct <- paste0(round(
  (stats_df$X.Fg2PtMade + stats_df$X.Fg3PtMade) /
    (stats_df$X.Fg2PtAtt + stats_df$X.Fg3PtAtt) * 100, 2), "%")

# variable for storing team wins
wins <- team_df$X.Wins

# variable set to same column name as stats_df to join them later
X.Team.Abbr. <- team_df$X.Team.Abbr.

# new data frame with teams and their respective wins
team_and_wins_df <- data.frame(X.Team.Abbr., wins, stringsAsFactors = F)

# joining wins to stats data frame
stats_with_wins <- left_join(stats_df, team_and_wins_df)

# finding league average for points (included in player rating eqn)
league_avg <- sum(stats_with_wins$total_points) / nrow(stats_with_wins)

# finding average for wins (included in player rating eqn)
win_avg <- sum(team_df$X.Wins) / nrow(team_df)

# finding average for amount of games played (included in player rating eqn)
games_played_avg <- sum(stats_with_wins$X.GamesPlayed) / nrow(stats_with_wins)

# ranking system based on how above or below average a player is in three
# categories: total points, team wins, and games played by a player
stats_with_wins$player_score <- round(
  stats_with_wins$total_points / league_avg +
  stats_with_wins$wins / win_avg +
  stats_with_wins$X.GamesPlayed / games_played_avg, 4)

# replacing "NA" values with "Not Available"
stats_with_wins[is.na(stats_with_wins)] <- "Not Available"

# filtering out the coaches
stats_with_wins <- stats_with_wins[!(stats_with_wins$X.Age == 0), ]

# filtering out those who did not play a game
stats_with_wins <- stats_with_wins[!(stats_with_wins$X.GamesPlayed == 0), ]

# adding a player rank column to rank players based on our equation
stats_with_wins <- stats_with_wins %>%
  arrange(-player_score) %>%
  mutate(player_rank = c(1:527)) %>%
  arrange(X.LastName)



#function for top 3 ranked NBA players
top_three <- function() {
  top_players <- stats_with_wins %>%
    filter(player_rank == 1 | player_rank == 2 | player_rank == 3) %>%
    select(player_names)

  paste0(top_players[1, ], ", ", top_players[2, ], ", and ", top_players[3, ])
}