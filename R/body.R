source("createAccount.R")
source("loginpage.R")
source("renderVisualisation.R")

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "analysis", h3("Analysis of data from ETAs")),
    tabItem(tabName = "viewData", uiOutput("contents")),
    tabItem(tabName = "visualisations", uiOutput("visualizationOutput")),
    tabItem(tabName = "prediction", h4("Prediction of data from ETAs")),
    tabItem(tabName = "predictionData", "Data to be predicted"),
    tabItem(tabName = "predictionTypes", uiOutput("predictionOutput")),
    tabItem(tabName = "createAccount",createAccount),
    tabItem(tabName = "login",loginpage)
  )

)
