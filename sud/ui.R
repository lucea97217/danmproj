library(shiny)
library(sudoku)
library(markdown)
library(lpSolve)

fluidPage(
    sidebarLayout(
        sidebarPanel(
            titlePanel("Sudoku Solver"),
            helpText(a('Solver Created by Chris White', href='http://math.utexas.edu/~cwhite', target="_blank")),
            helpText(a('User interface created by Michiel Koens', href='https://michielkoens.shinyapps.io/Sudoku/', target="_blank")),
            hr(),
            sliderInput("blanks", label = "Number of Blanks",
                        min = 9, max = 81, value = 40),
            actionButton("newButton", "New Puzzle"),
            hr(),
            h4('Solve Automatically:'),
            actionButton("solveButton", "Solve"),
            hr(),
            h4('Solve Manually:'),
            p('Use the row/column dropdowns to input your guesses:'),
            selectInput("row", label = "Row",
                        choices = list(1,2,3,4,5,6,7,8,9),
                        selected = 5),
            selectInput("col", label = "Column",
                        choices = list(1,2,3,4,5,6,7,8,9),
                        selected = 5),
            selectInput("value", label = "Value",
                        choices = list(1,2,3,4,5,6,7,8,9," "=0),
                        selected = 0),
            actionButton("setButton", "Set"),
            hr()
        ),
        mainPanel(
            tabsetPanel(
                tabPanel("Play", plotOutput("table")),
                tabPanel("About", includeHTML("about.html")),
                tabPanel("solver_f.R", includeHTML("solver_code.html")))
        )
    )
)
