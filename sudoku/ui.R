
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
            checkboxGroupInput("Diff", label = h3("Difficulté"),
                               choices = list("Facile" = 1, "Avancé" = 2),
                               selected = 1),
            hr(),

            img(src = "rat.jpg", height = 500, width = 400)
        ),


    mainPanel(
        h3("Sudoku"),
        plotOutput("plot"),
        h3("Solution"),
        plotOutput("plot_solve")

    ))
)
)
