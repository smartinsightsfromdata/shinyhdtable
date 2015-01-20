library(shiny)
library(shinyhdtable)

# Define UI for miles per gallon application
shinyUI(
#   basicPage(headerPanel("ShinySky Examples - hotable"), br(), br(), h4("Handsontable Input/Output"), 
#     div(class = "well container-fluid", div(class = "row-fluid", hotable("hotable1")))
# ) 
  fluidPage(sidebarPanel(h4("Shinyhtable Examples - hdtable")),
  mainPanel(
#     hdtable("hdtable1"),
    hdtable("hdtable2")
    )))
