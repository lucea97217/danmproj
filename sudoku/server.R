#

library(shiny)
library(shinyjs)
library(shinydashboard)
devtools::load_all()
shinyServer(function(input, output, session) {


    # Definition fonction sudoku

    # Nous avons donc ici deux façons conceptions de la "difficulté" soit nous nous fions
    # Au "backtracking" dans ce cas nous nous fions au nombre de retours
    # Soit nous partons du principe que plus il y a de "blancs dans un soduko plus la
    # Difficulté sera conséquente. Il faudra alors modifier freq.mean et/ou freq.max
    # Comme demandé dans l'énoncé du tp nous nous fixons à attempt pour étudier la difficulté
    # Mais nous pouvions très bien procéder autrement.
    observeEvent(input$load,{
        sudo <- danmsudo()
        sudo = "Fail"
        attempt = 0
        while (length(sudo)==1) {
            sudo <- danmsudo(ultimate= T, retry=F)
            attempt = attempt+1
        }
        sudo <- blanc(sudo)
        ssudo <- solver.sudoku(sudo)
        output$plot <- renderPlot({
            Sys.sleep(4) # system sleeping for 3 seconds for demo purpose
            plot(sudo)

    })
        observeEvent(input$solve,{

            output$plot_solve <- renderPlot({

                plot(ssudo)
            })
        })
        if(attempt < 1500){
            output$txt <- renderText(
                "niveau Facile"

            )
        }
        else if(attempt>= 1500 &attempt<=2500){
            output$txt <- renderText(
                "niveau Moyen"

            )
        }

        else if(attempt > 2500){
            output$txt <- renderText(
                "niveau difficile"

            )
        }
    })

    })





