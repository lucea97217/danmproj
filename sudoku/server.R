#

library(shiny)
library(shinyjs)
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

        sudo <- sudo.gaps(sudo)
        ssudo <- solver.sudoku(sudo, noisily=T)
        output$plot <- renderPlot({
            plot(sudo)

    })
        observeEvent(input$solve,{

            output$plot_solve <- renderPlot({

                plot.sudoku(ssudo)
            })
        })
        if(attempt < 500){
            output$txt <- renderText(
                "niveau Facile"

            )
        }
        else if(attempt>= 500 &attempt<=1800){
            output$txt <- renderText(
                "niveau Facile"

            )
        }

        else if(attempt > 1800){
            output$txt <- renderText(
                "niveau difficile"

            )
        }
    })

    })





