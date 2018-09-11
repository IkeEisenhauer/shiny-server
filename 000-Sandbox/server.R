# server.R

# routine to provide the info that will be displayed

# in each tab defined in ui.R


# include require libraries

library(shiny)
library(nortest)
library(agricolae)
library(car)


#########################################

# Main function for shinyServer:        #
# ANOVA utils
# defines all functions to populate     #

# objects set up in ui.R                #

#########################################

shinyServer(function(input, output) {
  
  
  
  
  
  
  
  ################################################################# 
  
  # Compute the forumla text in a reactive expression since it is # 
  
  # shared by the output$caption and output$mpgPlot expressions   #
  
  #################################################################
  
  formulaText <- reactive({
    
    paste("Data set:", input$vectorname)
    
  })
  
  ##  CI.H <- meanin+1.96*stdin # upper CI 
  #  CI.L <- meanin-1.96*stdin     # Calculate lower CI 
  #  xvals <- barplot(meanin, ylim=ylim, main="Interval Plot",...) # Plot bars 
  #  arrows(xvals, meanin, xvals, CI.H, angle=90) # Draw error bars 
  #  arrows(xvals, meanin, xvals, CI.L, angle=90)
  #  
 # }
#  
  
  
  ##############################################################
  # returns dataset and variable name based on text entered in #
  # input$vectorname and input$varname                         #
  ##############################################################
  
  whichdataset <- reactive({
    
    dataset <- get(input$vectorname) 
    #if (input$varname!="") dataset <- with(get(input$vectorname),get(input$varname))
    return(dataset)
    
  })
  
  

############################################################
# return the name for the response variable from the model #
# string                                                   #
############################################################

  get_resp_var <- reactive({
     return(as.character(formula(input$modstr))[2])  
  })
  
  get_factors <- reactive ({
    
    factorstr <- as.character(formula(input$modstr))[3]
    return(sub("\\s","",unlist(strsplit(factorstr,"[*+:]"))))
    
  })

  
  ######################################################
  # Return the formula text for printing as a caption  #
  ######################################################
  
  output$caption <- renderText({
    
    formulaText()
    
  })
  
  
    
  
  
  #######################################################
  # show data in the select vector/dataset and variable #
  #######################################################
  
  output$view <- renderPrint({
    
    whichdataset()
    
  })
  #######################################################
  # Display the structure of the selected data frame    #
  #######################################################
  output$structure <- renderPrint({
    
    dataset=whichdataset()
    str(dataset)
  }) 
  
  #######################################################
  # Display the normality of the selected data frame    #
  #######################################################
  output$normality <- renderPrint({
    
    dataset <- whichdataset()
    resp_var <- get_resp_var()
    factors <- get_factors()
    
    
      if (length(factors)==1) { 
          print(with(dataset,tapply(get(resp_var), get(factors[1]), shapiro.test)))
        }
    
    if (length(factors)==2) {
        f1=sub("^\\s+|\\s+$", "", factors[1])
        f2=sub("^\\s+|\\s+$", "", factors[2])
        print(with(dataset,tapply(get(resp_var), interaction(get(f1),get(f2)), shapiro.test)) )
                                                                        
    }
 
    
  })  
  
  #######################################################
  # Display the ANOVA Table                             #
  #######################################################
  
  output$anovatable <- renderPrint({
    
    dataset=whichdataset()
    aov.model<-aov(formula(input$modstr), data=dataset)
    print(aov.model)
    br()
    br()
    print(summary(aov.model))
    cat("Coefficients"); cat("\n")
    print(aov.model$coefficients)
    
  }) 
  
  
  
  
  
  
  ################################################
  # Generate a boxplot of the requested variable #
  # include outliers                             #
  ################################################
  output$gsPlot <- renderPlot({
    
    dataset=whichdataset()
    mt=paste(input$vectorname, " : " ,input$modstr)
    f=formula(input$modstr)
    boxplot(f,data=dataset, main=mt, col="green",
            ylab=as.character(f)[2], xlab=as.character(f)[3])
    
  }) 
  
#   output$iaplot <- renderPlot({
#   dataset=whichdataset()
#   interaction.plot(tension, wool, breaks, typ="l"))
#   
#     
#   })
#   
  
  #######################################################
  # plot the residuals                                  #
  #######################################################
  output$resid_plot <- renderPlot({
    
    dataset<-whichdataset()
    aov.model<-aov(formula(input$modstr), data=dataset)
    pv<-(ad.test(aov.model$residuals)$p.value)
    layout(matrix(c(1,2,3,4),2,2, byrow = TRUE))
    
    hist(aov.model$residuals, col="green", main=paste("Anderson Darling P-value= ", round(pv,4)))
    plot(aov.model$fitted, aov.model$residuals);  abline(h=0, col="red")
    plot(aov.model, which=2)
    plot(aov.model$residuals)
  })
  
  #######################################################
  # plot Tukey Groups                                   #
  #######################################################
  output$tukeyplot <- renderPlot({
    
    dataset<-whichdataset()
    aov.model<-aov(formula(input$modstr), data=dataset)
    #out<-HSD.test(aov.model, unlist(strsplit(input$tukeystr," ")))
    out<-HSD.test(aov.model, get_factors())
    par(cex=1, mar=c(3,8,1,1))
    
    #bar.group(out$groups)      
    bar.group(out$groups,horiz=T,col="blue",
              xlim=c(0,max(out$means[,1]*1.2)),las=1)
    
  })
  
  
  
  output$tukey <- renderPrint({
    
    dataset=whichdataset()
    aov.model<-aov(formula(input$modstr), data=dataset)
    #out<-HSD.test(aov.model, unlist(strsplit(input$tukeystr," ")))
   out <-HSD.test(aov.model, get_factors(), " ")
    print(out)
    
  })  
  
  output$fvalue <- renderPrint({
    cat(paste("F(.05,", input$dfnum, ",", input$dfdem,")=",qf(.95,input$dfnum,input$dfdem)))  
    
  }) 
  
  output$equalvar <- renderPrint({
    dataset=whichdataset()
    f=formula(input$modstr)
    
    if (length(strsplit(as.character(f)[3],split="*", fixed=T)[[1]])==2) {
      astr=strsplit(as.character(f)[[3]][1],"*",fixed=T)[[1]][1]
      bstr=strsplit(as.character(f)[[3]][1],"*",fixed=T)[[1]][2]
      a=with(dataset,get(strsplit(astr,split=" ")[[1]][1]))
      b=with(dataset,get(strsplit(bstr, split=" ")[[1]][2]))
      myf = formula(paste(as.character(f)[2],"~ interaction(a,b)"))
      
      print(bartlett.test(myf, data=dataset))  
    }
   
    if (length(strsplit(as.character(f)[3],split="*", fixed=T)[[1]])==1) {
        print(bartlett.test(f, data=dataset))
    }
   
    br()
    cat(paste("--------------------------------------------------","\n\n"))

    print(leveneTest(f, data=dataset))
  }) 
  
  output$help <- renderPrint({
    
    cat("One way Anove with response Y and Factor A \n model Y~A"); cat("\n\n")
    cat("Two way Anova with response Y and Factors A,B \n model Y~A+B "); cat("\n\n")
    cat("Two way Anova with response Y and Factors A,B and interaction (crossed)\n")
    cat(" model : Y~A*B   or \n model : Y~A+B+A:B"); cat("\n\n")
    cat("Two way ANOVA with response Y and Factors B nested in A\n")
    cat(" model : Y~A/B   or \n model : Y~A+A:B"); cat("\n\n")
    cat("One way with response Y and Random factor A\n")
    cat(" model : Y~Error(A)"); cat("\n\n")
    cat("Two Way with response Y and Random factor A and Fixed factor B\n")
    cat(" model : Y~Error(A) + B")
    
    
    
  })
  
  
}) # end of shinyServer


