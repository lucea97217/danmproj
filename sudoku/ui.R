#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
#shinyUI(fluidPage(
#    titlePanel("Exemple test"),
#    sidebarPanel(
#        numericInput(inputId="NumVar", label='Numéro de la variable :', min=1, max=4, value=1),
#        sliderInput(inputId="NbCla", label="Nombre de classes :", min=2, max=30, value=10),
#        radioButtons(inputId="Coul", label="Couleur de l’histogramme",
#                       choices = c("Bleu foncé"="darkblue","Vert"="green","Rouge"="red","gris"="grey"), selected="green")
#    ),
#    mainPanel(
#        verbatimTextOutput("sortie1"),
#        plotOutput("sortie2")
#    )
#))

shinyUI(fluidPage(
    titlePanel("Sudoku"),
    fluidRow(
        column(
            width = 12,
            align = "center",

            div(
                rHandsontableOutput(
                    outputId = "sortie3",
                    width = "100%", height = "100%"
                ),

                style = "margin: auto; width = 50%"
            )
        )
    ),

    sidebarLayout(
        sidebarPanel(
            actionButton(inputId = "load", label = "Load game"),
            actionButton(inputId = "solve", label = "Solve")
        ),

    mainPanel(
        h3("Sudoku Problem"),
        plotOutput("plot"),
        h3("Sudoku Solution"),
        plotOutput("plot_solve")
    ))
))

