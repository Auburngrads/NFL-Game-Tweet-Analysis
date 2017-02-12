plot_week_minute <- function(cur_week) {
      
      week_selected <- filter(no_zero, week == cur_week)
      
      ggplot(week_selected, aes(x=minute, fill=home)) + 
            geom_histogram(aes(weights=minute), binwidth = 1, show.legend = FALSE) + 
            facet_wrap( ~ hashtag, ncol=4, scales = "free") +
            teamColScale
      ggsave(str_c("graphs/week_by_minute/week_", cur_week, "_by_week.pdf"), 
             device = "pdf", dpi = 1600, width = 10, height = 8)
      x = 1
      
}

plot_week_quart <- function(cur_week) {
      
      week_selected <- filter(NFL.game.tweets, week == cur_week)
      
      ggplot(week_selected, aes(x=quarter, fill=home)) + 
            geom_histogram(aes(weights=quarter), binwidth = 1, show.legend = FALSE) + 
            facet_wrap( ~ hashtag, ncol=4, scales = "free") +
            teamColScale
      ggsave(str_c("graphs/week_by_quarter/week_", cur_week, "_by_week.pdf"), 
             device = "pdf", dpi = 1600, width = 10, height = 7)
      x = 1
}

plot_team_minute <- function(teamIn) {
      
      team_selected <- filter(NFL.game.tweets, home == teamIn | away == teamIn) %>%
            mutate(game_name = str_c("Week ", week, " ", away, " vs ", home))
      
      ggplot(team_selected, aes(x=minute, fill=home)) + 
            geom_histogram(aes(weights=minute), binwidth = 1, show.legend = FALSE) + 
            facet_wrap( ~ game_name, ncol=4, scales = "free") +
            teamColScale
      ggsave(str_c("graphs/Team_by_minute", teamIn, "_by_week.pdf"), 
             device = "pdf", dpi = 800, width = 25, height = 12.75, units = "cm")
      x = 1
}

plot_team_quart <- function(teamIn) {
      
      team_selected <- filter(NFL.game.tweets, home == teamIn | away == teamIn) %>%
            mutate(game_name = str_c("Week ", week, " ", away, " vs ", home))
      
      ggplot(team_selected, aes(x=quarter, fill=home)) + 
            geom_histogram(aes(weights=quarter), binwidth = 1, show.legend = FALSE) + 
            facet_wrap( ~ game_name, ncol=4, scales = "free") +
            teamColScale
      ggsave(str_c("graphs/Team_by_quarter/", teamIn, "_by_week.pdf"), 
             device = "pdf", dpi = 800, width = 9, height = 4.5)
      x = 1
}