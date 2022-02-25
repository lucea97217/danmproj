
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
            actionButton(inputId = "load", label = "Load game"),
            actionButton(inputId = "solve", label = "Solve"),
            verbatimTextOutput("txt"),
            img(src = "rat.jpg", height = 500, width = 400)


        ),


    mainPanel(
        h3("Sudoku Problem"),
        plotOutput("plot"),
        h3("Sudoku Solution"),
        plotOutput("plot_solve")

    ))
))

