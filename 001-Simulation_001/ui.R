##############################
### DoE Game 1 based on Diamond - ui.R ########
##############################

library(shiny) 
library(shinydashboard)

dashboardPage(
  skin="green",
  dashboardHeader(
    title="DoE Simulation 001 - Eisenhauer",
    titleWidth = 350
  ),
  dashboardSidebar(
    width = 350,
    sidebarMenu(
      menuItem("Overview", tabName = "Overview", icon = icon("info-circle")),
      menuItem("Process Controls", tabName = "ProcessControls", icon = icon("industry")),
      menuItem("Machine Controls", tabName = "MachineControls", icon = icon("steam")),
      menuItem("Material Properties", tabName = "MaterialProperties", icon = icon("flask")),
      menuItem("Experimental Results", tabName = "ExperimentalResults", icon = icon("table"))
      ),
    HTML("<hr>"),
    actionButton("addButton", "Run Experiment", icon=icon("play"))
  ),
  dashboardBody( 
    tabItems(
      tabItem(
        tabName = "Overview",
        h3("Simulation for Homework 1 and 2 STAT465")
      ),
      tabItem(
        tabName = "ProcessControls",
        div(style="height: 1200px;",box(
          width = 750,
          title = "Process Controls",
          status = "primary",
          solidHeader = TRUE,
          div(style="height: 150px;",sliderInput(inputId="A", label="A", min=0, max=3.5,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="C", label="C", min=0, max=2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="D", label="D", min=0, max=5,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="I", label="I", min=0.4, max=2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="L", label="L", min=0, max=2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="R", label="R", min=0, max=18,value = 1, step=0.1))
        ))
      ),
      tabItem(tabName = "MachineControls",
        div(style="height: 1200px;",box(
          width = 750,
          title = "Machine Controls",
          status = "primary",
          solidHeader = TRUE,
          div(style="height: 150px;",sliderInput(inputId="B", label="B", min=0, max=3,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="E", label="E", min=0, max=2.5,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="F", label="F", min=0, max=2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="K", label="K", min=0, max=1.2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="N", label="N", min=0, max=1.5,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="Q", label="Q", min=0, max=10,value = 1, step=0.1))
        ))
      ),
      tabItem(tabName = "MaterialProperties",
        div(style="height: 1200px;",box(
          width = 750,
          title = "Material Properties",
          status = "primary",
          solidHeader = TRUE,
          div(style="height: 150px;",sliderInput(inputId="G", label="G", min=0, max=2.5,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="H", label="H", min=0, max=2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="J", label="J", min=0, max=3,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="M", label="M", min=0, max=2,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="O", label="O", min=0.4, max=3.5,value = 1, step=0.1)),
          div(style="height: 150px;",sliderInput(inputId="P", label="P", min=0, max=2.0,value = 1, step=0.1))
        ))
      ),
      tabItem(tabName = "ExperimentalResults",
        h3("Experimental Results"),
        downloadButton("btnDownload", "Download Experimental Data"),
        tableOutput("table")
      )
    )
  )
)
