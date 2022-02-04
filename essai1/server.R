library(shiny)
library(ggplot2)
library(scales)
library(tidyverse)
library(sudoku)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
    # creating outcome with reactive variable
    # output also condition of the input selection radio button

    data_source <- reactive({
        if(input$load==0)
            return(rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame())

        # input$load
        isolate({
            if (input$select_source == "text"){
                if(nchar(input$text)!=81){
                    data=rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame()
                }else if(str_count(input$text,"0")<4 |str_count(input$text,"0")>64){
                    data=rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame()
                }else{
                    text_source <- input$text
                    text_source_split = str_split(text_source, pattern="")
                    data = matrix(as.numeric(unlist(text_source_split)), nrow = 9, byrow = TRUE)
                }

            } else if (input$select_source == "random") {
                if(input$number<17 | input$number>77){
                    data=rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame()
                } else {
                    data = generateSudoku(Nblank=81-input$number, print.it=FALSE)
                }

            } else if (input$select_source == "sudoku_org") {
                error_catch = try(fetchSudokuUK(input$uk_date),silent=TRUE)

                if(class(error_catch)=="try-error"){
                    data=rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame()
                } else {
                    data = fetchSudokuUK(input$uk_date)
                }
            }
            return(data)
        })
    })

    observeEvent(input$load, {
        if (input$select_source == "text" & nchar(input$text)!=81){
            showModal(modalDialog(
                title = h3("Input Error"),
                paste("Input length must be 81 digits. Your current input has",nchar(input$text),"digits")
            ))
        }else if (input$select_source == "text" & nchar(input$text)==81 & (str_count(input$text,"0")<4 |str_count(input$text,"0")>64 )){
            # showNotification(paste("Number of clue must be between 17 and 77. Your current number of clues are",81-str_count(input$text,"0")),duration = 10,type="error")
            showModal(modalDialog(
                title = h3("Input Error"),
                paste("Number of clue must be between 17 and 77. Your current number of clues are",81-str_count(input$text,"0"))
            ))
        }else if (input$select_source == "random" &(input$number<17 | input$number>77)){
            # showNotification(paste("Number of clue must be between 17 and 77. Your current number of clues are",input$number),duration = 10,type="error")
            showModal(modalDialog(
                title = h3("Input Error"),
                paste("Number of clue must be between 17 and 77. Your current number of clues are",input$number)
            ))
        }else if (input$select_source == "sudoku_org" & class(try(fetchSudokuUK(input$uk_date),silent=TRUE))=="try-error"){
            # showNotification(paste("Number of clue must be between 17 and 77. Your current number of clues are",input$number),duration = 10,type="error")
            showModal(modalDialog(
                title = h3("Input Error"),
                HTML("Unable to download puzzle.<br>
                Puzzle is not yet available in this date. Please check another date.")
            ))
        }
    })

    # input become data frame with additional data
    input_problem <- reactive({
        data_output = data_source()

        input.df = expand.grid(x=1:ncol(data_output), y=1:nrow(data_output))
        input.df$val = data_output[as.matrix(input.df[c('y','x')])]
        input.df = as.data.frame(input.df) %>% mutate(rowNumb=row_number()) %>%
            mutate(color_grid = ifelse((x<4 & (rowNumb<28 | rowNumb>54))|(x>6 & (rowNumb<28 | rowNumb>54))|((x>3 & x<7) & (rowNumb>27 & rowNumb<55)),1,0)) %>%
            mutate(color_grid = factor(color_grid,levels=c("0","1"))) %>%
            mutate(color_label = factor(ifelse(val==0,0,1),levels=c("0","1")))%>%
            mutate(val_null = ifelse(val==0,NA,val))
    })

    # Solved Reactive ini adalah return ketika pertama kali di klik dan kalau
    # load button di klik
    sudoku_solution = reactiveVal(rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame())

    # ini yang terjadi juga kalau load button diklik. maka akan mereset value dari
    # sudoku solution
    observeEvent(input$load,{
        data = rep(NA,81) %>% matrix(nrow = 9) %>% as.data.frame()
        sudoku_solution(data)
    })

    # ini yang terjadi ketika solve button di klik.
    # value dari sudoku solution akan diganti dengan solusinya
    observeEvent(input$solve,{
        if(sum(is.na(data_source()))>1){
            showModal(modalDialog(
                title = h3("Solution Error"),
                "Please verify your input"
            ))
        }
        else if(is.null(solveSudoku(data_source()))){
            # showNotification("The problem do not have solution. Please check again",duration = 10,type="warning")
            showModal(modalDialog(
                title = h3("Solution Error"),
                "The problem do not have solution. Please check the input again"
            ))
        }
        else {
            data_sol = solveSudoku(data_source(),print.it = FALSE)
            sudoku_solution(data_sol)
        }
    })

    # solution become data frame with additional data
    data_solve <- reactive({
        input.df = input_problem()

        sudoku_sol = sudoku_solution()
        solved_df = expand.grid(x=1:9,y=1:9)
        solved_df$val=sudoku_sol[as.matrix(solved_df[c('y','x')])]
        solved_df = as.data.frame(solved_df) %>%
            mutate(color_grid=input.df$color_grid) %>%
            mutate(color_label = input.df$color_label)
    })

    output$plot <- renderPlot({
        # plotting
        input_df = input_problem()

        ggplot(input_df, aes(x=x, y=y,label=val_null, fill=color_grid)) +
            geom_tile(colour='black') +
            geom_text(aes(size = 8, colour=color_label)) +
            scale_y_reverse() +
            scale_fill_manual(values = c("light blue","white")) +
            scale_colour_manual(values=c("red", "black"))+
            coord_equal()+
            theme_classic() +
            theme(axis.text  = element_blank(),
                  panel.grid = element_blank(),
                  axis.line  = element_blank(),
                  axis.ticks = element_blank(),
                  axis.title = element_blank(),
                  legend.position = "none")

    })

    output$plot_solve <- renderPlot({
        solved_df = data_solve()

        ggplot(solved_df, aes(x=x, y=y, label=val,fill=color_grid)) +
            geom_tile(colour='black') +
            geom_text(aes(size = 8, colour=color_label)) +
            scale_y_reverse() +
            scale_fill_manual(values = c("light blue","white")) +
            scale_colour_manual(values=c("red", "black"))+
            coord_equal()+
            theme_classic() +
            theme(axis.text  = element_blank(),
                  panel.grid = element_blank(),
                  axis.line  = element_blank(),
                  axis.ticks = element_blank(),
                  axis.title = element_blank(),
                  legend.position = "none")
    })

})
