#

library(shiny)
library(shinyjs)
library(shinydashboard)
devtools::load_all()
shinyServer(function(input, output, session) {


    # Definition fonction sudoku
    observeEvent(input$load,{
        sudo <- danmsudo()
        sudo = "Fail"
        attempt = 0
        output$x = renderText( input$Diff)
        while (length(sudo)==1) {
            sudo <- danmsudo(ultimate=T, iterate=F)
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





