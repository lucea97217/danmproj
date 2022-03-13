
library(shiny)
library(shinythemes)
library(shinydashboard)



img <- 'http://northerntechmap.com/assets/img/loading-dog.gif'
imgsize <- "40%"


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
#------------------ Slider Panel ----------------------------
    headerPanel("Sudoku Danmproj"),
    sidebarLayout(
        sidebarPanel(
            tags$style(type='text/css', '#txt {background-color: rgba(0,0,0,0); color: white;}'),
            verbatimTextOutput("txt"),
            hr(),
            img(src = "rat.jpg", height = 500, width = 400)
        ),

#-------------- -------------------------------------

#---------------------- page principale --------------------
    mainPanel(
      tags$head(
        tags$style(HTML("
      @import url('//fonts.googleapis.com/css?family=Lobster|Cabin:400,700');

      h3 {
        font-family: 'Lobster', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }

    "))
      ),
        h3("Sudoku"),

#-------------- mise en place du chien loading --------------
        singleton(tags$head(HTML("
<script type='text/javascript'>

/* When recalculating starts, show loading screen */
$(document).on('shiny:recalculating', function(event) {
$('div#divLoading').addClass('show');
});

/* When new value or error comes in, hide loading screen */
$(document).on('shiny:value shiny:error', function(event) {
$('div#divLoading').removeClass('show');
});

</script>"))),

                      # CSS Code
                      singleton(tags$head(HTML(paste0("
<style type='text/css'>
#divLoading
{
  display : none;
  }
  #divLoading.show
  {
  display : block;
  position : fixed;
  z-index: 100;
  background-image : url('",img,"');
  background-size:", imgsize, ";
  background-repeat : no-repeat;
  background-position : center;
  left : 30%;
  bottom : 20%;
  right : 0;
  top : 0;
  }
  #loadinggif.show
  {
  left : 50%;
  top : 50%;
  position : absolute;
  z-index : 101;
  -webkit-transform: translateY(-50%);
  transform: translateY(-50%);
  width: 100%;
  margin-left : -16px;
  margin-top : -16px;
  }
  div.content {
  width : 1000px;
  height : 1000px;
  }

</style>")))),
# ----------------------------- action buttons -----------------------
                      tags$body(HTML("<div id='divLoading'> </div>")),
                          plotOutput('plot', width = "800px", height = "450px"),

                          actionButton('load', 'Load Game',
                                       style="color: #fff; background-color: rgba(0,0,0,100); color: white;}"),
                          actionButton('solve', 'Solution',
                                      style="color: #fff; background-color: rgba(0,0,0,100); color: white;}"),



        h3("Solution"),
        plotOutput("plot_solve",width = "800px", height = "450px")

    ))
)
)
