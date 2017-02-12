library(shiny)
library(tidyverse)

shinyServer(function(input, output) {

      
      
      output$weekOrTeam <- renderUI({
            if (is.null(input$whatBy) | input$whatBy == "Week") {
                  selectInput("week",
                              "Week:",
                              as.character(levels(NFL.game.tweets$week)),
                              selected = "14")
            }
            else if (input$whatBy == "Team") {
                  selectInput("team", 
                              "Team", 
                              as.character(levels(NFL.game.tweets$home)), 
                              selected = "NE")
            }
      })
      
      output$minQuart <- renderUI({
            if (input$whatBy == "Week" | input$whatBy == "Team") {
                  selectInput("minOrQuart",
                              "Display by minute of quarter?",
                              c("Minute", "Quarter"),
                              selected = "Minute")
            }
      })
      
      output$plotTweets <- renderPlot({
            
            if (input$whatBy == "Week") {
                  cur_week <- as.character(input$week)
                  
                  week_selected <- filter(NFL.game.tweets, week == cur_week) 
                        
                  if (input$minOrQuart == "Minute") {
                        ggplot(week_selected, aes(x=minute, fill=home)) + 
                              geom_histogram(aes(weights=minute), binwidth = 1, 
                                             show.legend = FALSE) + 
                              facet_wrap( ~ hashtag, ncol=4, scales = "free") +
                              teamColScale
                  }
                  else if (input$minOrQuart == "Quarter") {
                        ggplot(week_selected, aes(x=quarter, fill=home)) + 
                              geom_histogram(aes(weights=quarter), binwidth = 1, 
                                             show.legend = FALSE) + 
                              facet_wrap( ~ hashtag, ncol=4, scales = "free") +
                              teamColScale
                  }
                  
            }
            else if (input$whatBy == "Team") {
                  team_selected <- filter(NFL.game.tweets, 
                                          home == input$team | away == input$team) %>%
                        mutate(game_name = str_c("Week ", week, " ", away, " vs ", home))
                  
                  if (input$minOrQuart == "Minute") {
                        ggplot(team_selected, aes(x=minute, fill=home)) + 
                              geom_histogram(aes(weights=minute), binwidth = 1, 
                                             show.legend = FALSE) + 
                              facet_wrap( ~ game_name, ncol=4, scales = "free") +
                              teamColScale
                  }
                  else if (input$minOrQuart == "Quarter") {
                        ggplot(team_selected, aes(x=quarter, fill=home)) + 
                              geom_histogram(aes(weights=quarter), binwidth = 1, 
                                             show.legend = FALSE) + 
                              facet_wrap( ~ game_name, ncol=4, scales = "free") +
                              teamColScale
                  }
            }
            else if (input$whatBy == "Average per Game") {
                  ggplot(teams, aes(x = reorder(Team, -AvePerGame), y = AvePerGame, fill = Team)) + 
                        geom_bar(stat = "identity", show.legend = TRUE) +
                        theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
                        labs(y = "Average Tweets Per Game", x = "Teams") + 
                        teamColScale
            }
      })
      
})

