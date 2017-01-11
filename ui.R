library(shiny)

shinyUI(fluidPage(
  titlePanel("European Prospective Investigation into Cancer and Nutrition"), br(), 
  
  mainPanel(
    tabsetPanel(
      
      # Demographics
      tabPanel("Demographics", br(), dataTableOutput("tableOne")),
      
      # Other Features
      tabPanel("Other Features", br(), dataTableOutput("tableTwo")),
      
      # Risk Measurements
      tabPanel("Risk Measurements", br(), dataTableOutput("tableFour")),
      
      # General info
      tabPanel("Correlation", br(), plotOutput("scatterOne")),
      
      # Bar chart tabs
      tabPanel("Work Activity",
        column(6, plotOutput("barOne")), column(6, plotOutput("barTwo")),
        column(6, plotOutput("barThree")), column(6, plotOutput("barFour"))
      ),
      
      # Hazard ratio tabs
      tabPanel("Hazard Ratios", br(), tabsetPanel(
        tabPanel("Red Meat", plotOutput("hrOne")),
        tabPanel("Processed Meat", plotOutput("hrTwo")),
        tabPanel("Red/Processed Meat", plotOutput("hrThree")),
        tabPanel("Poultry", plotOutput("hrFour")),
        tabPanel("Fish", plotOutput("hrFive"))
      ))
    )
  )
))
