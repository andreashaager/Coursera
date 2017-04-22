#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
     
     dataset <- reactive( {
          mtcars[sample(nrow(mtcars), input$sampleSize),]
     })
     
     output$plot <- reactivePlot(function() {
          
          p <- ggplot(dataset(), aes_string(x=input$x, y=input$y)) + geom_point()
          
          if (input$color != 'None')
               p <- p + aes_string(color=input$color)
          
          facets <- paste(input$facet_row, '~', input$facet_col)
          if (facets != '. ~ .')
               p <- p + facet_grid(facets)
          
          # if (input$jitter)
          #      p <- p + geom_jitter()
          if (input$smooth)
               p <- p + geom_smooth()
          
          print(p)
          
     }, height=600
     )
     
})
