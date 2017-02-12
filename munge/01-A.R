NFL.game.tweets <- mutate(NFL.game.tweets, 
                          tweetCreated = ymd_hms(tweetCreated), 
                          hashtag = str_c(away, " vs ", home),
                          home = as.factor(home), 
                          away = as.factor(away), 
                          week = as.factor(week),
                          quarter = ifelse(quarter == 0, 1, quarter))

games <- group_by(NFL.game.tweets, week, home, away) %>%
      summarise(totalTweets = n(), length = max(minute)) %>%
      mutate(tweetsPerMin = as.integer(totalTweets/length), 
             hashtag = str_c(away, "vs", home))

teamsAway <- select(NFL.game.tweets, week, away) %>% 
      group_by(week, away) %>% 
      summarise(totalTweets = n()) %>% 
      rename(Team = away)

teamsHome <- select(NFL.game.tweets, week, home) %>% 
      group_by(week, home) %>% 
      summarise(totalTweets = n()) %>% 
      rename(Team = home)

teams <- rbind(teamsHome, teamsAway) %>%
      spread(week, totalTweets) %>%
      mutate(Total = rowSums(.[-1], na.rm = TRUE), 
             AvePerGame = as.integer(rowMeans(.[-1], na.rm = TRUE)))

teamColors <- team.colours$X.colour1.
names(teamColors) <- levels(teams$Team)
teamColScale <- scale_fill_manual(name = "Team", values = teamColors)