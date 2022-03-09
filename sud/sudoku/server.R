#
# This is the server logic of a Shiny web application. You can run the


library(shiny)
library(shinyjs)
devtools::load_all()
shinyServer(function(input, output, session) {


    # Definition fonction sudoku
    observeEvent(input$load,{

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



