
source("createAccount.R")
source("loginpage.R")
source("renderVisualisation.R")
source("home.R")

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "home", home),
    tabItem(tabName = "analysis", h3("Analysis of data from ETAs")),
    tabItem(tabName = "viewData", uiOutput("contents")),
    tabItem(tabName = "visualisations", uiOutput("visualizationOutput")),
    tabItem(tabName = "prediction", h4("Prediction of data from ETAs")),
    tabItem(tabName = "predictionData", uiOutput("predictionDataOutput")),
    tabItem(tabName = "predictionTypes", uiOutput("predictionOutput")),
    tabItem(tabName = "createAccount",createAccount),
    tabItem(tabName = "login",loginpage)
  )
  
)
