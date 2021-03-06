##########################################
##### DoE Game 1 [Based on Diamond] - server.R ###
##########################################

library(shiny)

shinyServer(function(input, output) { 

  # Reset Data
    exp_data = read.table(text="",
                         col.names=c("IDX","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","YLD"),
                          colClasses = c("double","double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double","double",
                                        "double","double","double") 
                         )
  
  # The important part of reactiveValues()
    values <- reactiveValues()
    values$df <- exp_data
    observe({
        # your action button condition
        if(input$addButton > 0) {
          # Create Yield
          isolate(YLD <- sqrt(abs(15*(2-(input$A-1)^2-(input$F-1)^2))) + 15*(input$B)^2*exp(0.64-(input$B)^2-10*(input$B-input$G)^2) + 50*input$C*exp(0.04-(input$C)^2-10*(6*input$C-input$H)^2) + 0.5*input$D*input$E + 5*abs(input$I-input$K) + (input$J)^2 + (input$M)^2 - (input$J*input$M) + 10*exp(-100*((0.72*input$L-1.3)^2+(input$N-1.3)^2)) + rnorm(1,0,.1))
          
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
                               input$M,
                               input$N,
                               input$O,
                               input$P,
                               input$Q,
                               input$R,
                               YLD))
          # update your data
          # note the unlist of newLine, this prevents a bothersome warning message that the rbind will return regarding rownames because of using isolate.
          isolate(values$df <- rbind(as.matrix(values$df), unlist(newLine)))
        }
      })

      output$btnDownload <- downloadHandler(
        filename = function() {paste("Experimental_Data_001", ".csv", sep='')},
        content = function(file) {
          write.csv(values$df,file)
        }
      )  
                            
      output$table <- renderTable({values$df}, include.rownames=F)
        
  })
