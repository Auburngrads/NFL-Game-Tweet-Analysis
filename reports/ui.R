library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
      
      # Application title
      titlePanel("NFL Game Tweets"),

      fluidRow(
            column(3,
                   selectInput("whatBy",
                               "Display by week or by team?",
                               c("Week", "Team", "Average per Game"),
                               selected = "Week")),
            column(4,
                   uiOutput("weekOrTeam")),
            column(5,
                   uiOutput("minQuart"))
      ),
            
      plotOutput("plotTweets")

))