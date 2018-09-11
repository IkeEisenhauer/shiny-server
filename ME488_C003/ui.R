##############################
### DoE ME 488 In Class 003 - ui.R ########
##############################

library(shiny) 
library(shinydashboard)

dashboardPage(
  skin="green",
  dashboardHeader(
    title="ME 488 Homework Simulation Class 003 - Eisenhauer",
    titleWidth = 350
  ),
  dashboardSidebar(
    width = 350,
    sidebarMenu(
      menuItem("Overview", tabName = "Overview", icon = icon("info-circle")),
      # menuItem("Process Controls", tabName = "ProcessControls", icon = icon("industry")),
      menuItem("Machine Controls", tabName = "MachineControls", icon = icon("steam")),
      # menuItem("Material Properties", tabName = "MaterialProperties", icon = icon("flask")),
      menuItem("Experimental Results", tabName = "ExperimentalResults", icon = icon("table"))
      ),
    HTML("<hr>"),
    actionButton("addButton", "Run Experiment", icon=icon("play"))
  ),
  dashboardBody( 
    tabItems(
      tabItem(
        tabName = "Overview",
        h3("Simulation for Homework 5 for ME 488")
      ),
      tabItem(tabName = "MachineControls",
        div(style="height: 1200px;",box(
          width = 750,
          title = "Machine Controls",
          status = "primary",
          solidHeader = TRUE,
          div(style="height: 150px;",sliderInput(inputId="B", label="Brake Fluid Viscosity(B)", min=20, max=50,value = 25, step=5)),
          div(style="height: 150px;",sliderInput(inputId="E", label="Brake Fluid Temperature(E)", min=50, max=120,value = 70, step=5)),
          div(style="height: 150px;",sliderInput(inputId="Q", label="Engine Size(Q)", min=2, max=16,value = 2, step=2))
        ))
      )
      ,
      tabItem(tabName = "ExperimentalResults",
        h3("Experimental Results"),
        downloadButton("btnDownload", "Download Experimental Data"),
        tableOutput("table")
      )
    )
  )
)
