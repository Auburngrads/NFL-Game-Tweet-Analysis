library(shiny)
library(tidyverse)

shinyServer(function(input, output) {

      
      
      output$weekOrTeam <- renderUI({
            if (is.null(input$whatBy) | input$whatBy == "Week") {
                  sliderInput("week",
                              "Week:",
                              min = 10,
                              max = 17,
                              value = 14)
            }
            else if (input$whatBy == "Team") {
                  selectInput("team", 
                              "Team", 
                              as.character(levels(NFL.game.tweets$home)), 
                              selected = "NE")
            }
      })
      
      output$plotTweets <- renderPlot({
            
            if (input$whatBy == "Week") {
                  cur_week <- as.character(input$week)
                  
                  week_selected <- filter(NFL.game.tweets, week == cur_week) 
                        
                  ggplot(week_selected, aes(x=minute, fill=home)) + 
                        geom_histogram(aes(weights=minute), binwidth = 1, show.legend = FALSE) + 
                        facet_wrap( ~ hashtag, ncol=4, scales = "free") +
                        teamColScale
            }
            else if (input$whatBy == "Team") {
                  team_selected <- filter(NFL.game.tweets, 
                                          home == input$team | away == input$team) %>%
                        mutate(game_name = str_c("Week ", week, " ", away, " vs ", home))
                  
                  ggplot(team_selected, aes(x=minute, fill=home)) + 
                        geom_histogram(aes(weights=minute), binwidth = 1, show.legend = FALSE) + 
                        facet_wrap( ~ game_name, ncol=4, scales = "free") +
                        teamColScale
            }
      })
      
})

