source("createAccount.R")
source("loginpage.R")
source("renderVisualisation.R")

body <- dashboardBody(
  tags$link(rel = "stylesheet", type = "text/css", href = "css/animate.min.css"),
  tags$link(rel = "stylesheet", type = "text/css", href = "css/bootstrap.min.css"),
  tags$link(rel = "stylesheet", type = "text/css", href = "css/bootstrap-theme.min.css"),
  tags$link(rel = "stylesheet", type = "text/css", href = "css/font-awesome.min.css"),
  tags$link(rel = "stylesheet", type = "text/css", href = "css/overwrite.css"),
  tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css"),
  tabItems(
    tabItem(tabName = "home",includeHTML("HomePage/index.html")),
    tabItem(tabName = "analysis", h3("Analysis of data from ETAs")),
    tabItem(tabName = "viewData", uiOutput("contents")),
    tabItem(tabName = "visualisations", uiOutput("visualizationOutput")),
    tabItem(tabName = "prediction", h4("Prediction of data from ETAs")),
    tabItem(tabName = "predictionData", "Data to be predicted"),
    tabItem(tabName = "predictionTypes", "Types of predictions"),
    tabItem(tabName = "createAccount",createAccount),
    tabItem(tabName = "login",loginpage)
  )

)
