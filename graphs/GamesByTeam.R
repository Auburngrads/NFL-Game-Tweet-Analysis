filter(games, home == "DAL" | away == "DAL") %>% 
      ggplot(aes(x = hashtag, y = totalTweets)) + 
            geom_bar(stat = "identity") + 
            theme(axis.text.x = element_text(angle = 35, hjust = 1))

##Show average tweets per week by team
ggplot(teams, aes(x = reorder(Team, -AvePerGame), y = AvePerGame, fill = Team)) + 
      geom_bar(stat = "identity", show.legend = FALSE) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
      labs(y = "Average Tweets Per Game", x = "Teams") + 
      teamColScale

