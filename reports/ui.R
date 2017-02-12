library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
      
      # Application title
      titlePanel("NFL Game Tweets"),

      fluidRow(
            column(3,
                   selectInput("whatBy",
                               "Display by week or by team?",
                               c("Week", "Team"),
                               selected = "Week")),
            column(4,
                   uiOutput("weekOrTeam")
            )
      ),
            
      plotOutput("plotTweets")

))