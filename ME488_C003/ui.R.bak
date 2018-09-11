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
      tabItem(tabName = "Experimental Settings",
        div(style="height: 1200px;",box(
          width = 750,
          title = "Experimental Settings",
          status = "primary",
          solidHeader = TRUE,
          div(style="height: 150px;",sliderInput(inputId="B", label="Brake Fluid Viscosity(B)", min=20, max=50,value = 25, step=5)),
          div(style="height: 150px;",sliderInput(inputId="E", label="Brake Fluid Temperature(E)", min=50, max=120,value = 70, step=5)),
          div(style="height: 150px;",sliderInput(inputId="Q", label="Engine Size(Q)", min=2, max=16,value = 2, step=2))
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
