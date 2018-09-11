##############################
### DoE ME 488 In Class 002 - server.R ###
### Factorial Model ####
##############################

library(shiny)

shinyServer(function(input, output) { 

  # Reset Data
    exp_data = read.table(text="",
                         col.names=c("IDX","B","E","Q","YLD"),
                          colClasses = c("double","double","double","double","double") 
                         )
  
  # The important part of reactiveValues()
    values <- reactiveValues()
    values$df <- exp_data
    observe({
        # your action button condition
        if(input$addButton > 0) {
          # Create Yield
          isolate(YLD <- 25+50*input$Q+0.5*input$E-5*input$B + rnorm(1,0,5))
          
          # create the new line to be added from your inputs
          newLine <- isolate(c(nrow(as.matrix(values$df))+1,
                               #input$A,
                               input$B,
                               #input$C,
                               #input$D,
                               input$E,
                               #input$F,
                               #input$G,
                               #input$H,
                               #input$I,
                               #input$J,
                               #input$K,
                               #input$L,
                               #input$M,
                               #input$N,
                               #input$O,
                               #input$P,
                               input$Q,
                               #input$R,
                               YLD))
          # update your data
          # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
          isolate(values$df <- rbind(as.matrix(values$df), unlist(newLine)))
        }
      })

      output$btnDownload <- downloadHandler(
        filename = function() {paste("Experimental_Data_C003", ".csv", sep='')},
        content = function(file) {
          write.csv(values$df,file)
        }
      )  
                            
      output$table <- renderTable({values$df}, include.rownames=F)
        
  })
