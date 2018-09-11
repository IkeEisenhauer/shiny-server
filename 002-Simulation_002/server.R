##########################################
##### DoE Game 2 [Based on Diamond] - server.R ###
##########################################

library(shiny)

shinyServer(function(input, output) { 

  # Reset Data
    exp_data = read.table(text="",
                         col.names=c("IDX","A","B","C","D","E","F","G","H","I","J","K","L","YLD"),
                          colClasses = c("double","double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double","double",
                                        "double") 
                         )
  
  # The important part of reactiveValues()
    values <- reactiveValues()
    values$df <- exp_data
    observe({
        # your action button condition
        if(input$addButton > 0) {
          # Create Yield
          isolate(YLD <- sqrt(abs(15*(2-(input$A-1)^2-(input$D-1)^2))) + 15*(input$B)^2*exp(0.64-(input$B)^2-10*(input$B-input$E)^2) + 50*input$C*exp(0.04-(input$C)^2-10*(6*input$C-input$F)^2) + 5*abs(input$G-input$H) + 10*exp(-100*((0.72*input$I-1.3)^2+(input$J-1.3)^2)) + rnorm(1,0,0.5))
          
          # create the new line to be added from your inputs
          newLine <- isolate(c(nrow(as.matrix(values$df))+1,input$A,
                               input$B,
                               input$C,
                               input$D,
                               input$E,
                               input$F,
                               input$G,
                               input$H,
                               input$I,
                               input$J,
                               input$K,
                               input$L,
                               YLD))
          # update your data
          # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
          isolate(values$df <- rbind(as.matrix(values$df), unlist(newLine)))
        }
      })

      output$btnDownload <- downloadHandler(
        filename = function() {paste("Experimental_Data_002", ".csv", sep='')},
        content = function(file) {
          write.csv(values$df,file)
        }
      )  
                            
      output$table <- renderTable({values$df}, include.rownames=F)
        
  })
