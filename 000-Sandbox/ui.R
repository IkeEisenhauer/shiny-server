# ui.R

library(shiny)
library(nortest)
library(agricolae)
library(car)

shinyUI(fluidPage(
  
    
  # Application title
  
  headerPanel("ANOVA Tools"),
    
  sidebarPanel( textInput("vectorname", "Enter Data frame: ", "warpbreaks"),
                textInput("modstr",     "Enter Model: ", "breaks~tension"),
                #textInput("tukeystr", "Enter list of factors to Tukey test",""),
                #numericInput("dfnum", "df Numerator",""),
                #numericInput("dfdem", "df Demoninator", ""),
                
                submitButton("Update View")          
                
  ),
    
  mainPanel(
    
  
    h2(textOutput("caption")),
    
   tabsetPanel(
      tabPanel("Show Data",         verbatimTextOutput("view")),
      tabPanel("Structure",         verbatimTextOutput("structure")),
      tabPanel("Normality",         verbatimTextOutput("normality")),
      tabPanel("Box Plot",          plotOutput("gsPlot")),
      tabPanel("Interaction Plot",  plotOutput("iaplot")),
      tabPanel("ANOVA Table",       verbatimTextOutput("anovatable")),
      tabPanel("Tukey Comparisons", plotOutput("tukeyplot"), verbatimTextOutput("tukey")),
      #tabPanel("F value",           verbatimTextOutput("fvalue")),
      tabPanel("Equal Variance",    verbatimTextOutput("equalvar")),
      tabPanel("Residual",          plotOutput("resid_plot")),
      tabPanel("Help",              verbatimTextOutput("help"))
    )
        
  )
  
  
  
  
))
