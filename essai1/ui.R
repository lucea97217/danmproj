library(shiny)
library(sudoku)
library(ggplot2)
library(scales)
library(tidyverse)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Sudoku Solver"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            # select source of the game using radio button
            radioButtons("select_source",
                         label="Select source to start your game",
                         choices=c("User input"="text",
                                   "Random game seed"="random",
                                   "sudoku.org.uk"="sudoku_org"),
                         selected="text"),

            # condition if text is selected
            conditionalPanel(
                condition = "input.select_source == 'text'",
                textInput("text", "Enter your sudoku game")
            ),

            # condition if random is selected
            conditionalPanel(
                condition = "input.select_source=='random'",
                numericInput("number","Enter number of clues (between 17 to 77)",value=34,min=17,max=77)
            ),

            # condition if UK org is selected
            conditionalPanel(
                condition = "input.select_source == 'sudoku_org'",
                dateInput("uk_date","Select Date",
                          min="2006-01-01",
                          max=Sys.Date()+1,
                          value = Sys.Date()
                )
            ),

            # load game to trigger reactivity
            actionButton(inputId = "load", label = "Load game"),
            actionButton(inputId = "solve", label = "Solve")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            h3("Sudoku Problem"),
            plotOutput("plot"),
            h3("Sudoku Solution"),
            plotOutput("plot_solve")
        )
    )
)
)
