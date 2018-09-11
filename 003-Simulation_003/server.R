##########################################
##### DoE Game 3 [Based on Diamond] - server.R ###
##########################################

library(shiny)

shinyServer(function(input, output) { 

  # Reset Data
    exp_data = read.table(text="",
                         col.names=c("C","F","G","K","YLD"),
                          colClasses = c("double","double","double","double","double") 
                         )
  
  # The important part of reactiveValues()
    values <- reactiveValues()
    values$df <- exp_data
    observe({
        # your action button condition
        if(input$addButton > 0) {
          # Create Yield
          isolate(YLD <- 9-3*(abs(input$F+input$G-3))+4*(1+(input$C-1.3)^2-(input$K-0.7)^2-0.2*(input$C-1.3)*(input$K-0.7)) + rnorm(1,0,1))
          
          # create the new line to be added from your inputs
          newLine <- isolate(c(input$C,
                               input$F,
                               input$G,
                               input$K,
                               YLD))
          # update your data
          # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
          isolate(values$df <- rbind(as.matrix(values$df), unlist(newLine)))
        }
      })

      output$btnDownload <- downloadHandler(
        filename = function() {paste("Experimental_Data_003", ".csv", sep='')},
        content = function(file) {
          write.csv(values$df,file)
        }
      )  
                            
      output$table <- renderTable({values$df}, include.rownames=F)
        
  })
