
library(shiny)
library(shinythemes)



shinyUI(fluidPage(theme = shinytheme("darkly"),
                  tags$head(
                      tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h1 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    "))
                  ),
    headerPanel("Sudoku Danmproj"),
    sidebarLayout(
        sidebarPanel(
            h4("Générer votre sudoku"),
            actionButton(inputId = "load", label = "Load game"),
            hr(),
            h4("Afficher la solution"),
            actionButton(inputId = "solve", label = "Solve"),
            hr(),
            verbatimTextOutput("txt"),
            hr(),
            img(src = "rat.jpg", height = 500, width = 400)
        ),


    mainPanel(
        h3("Sudoku"),
        plotOutput("plot"),
        h3("Solution"),
        plotOutput("plot_solve")

    ))
))

