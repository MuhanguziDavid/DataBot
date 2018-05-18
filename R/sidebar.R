source("fileInput.R")
source("renderVisualisation.R")
source("analysisTypes.R")

sidebar <- dashboardSidebar(
  tags$head(tags$script(HTML("
      Shiny.addCustomMessageHandler('manipulateMenuItem', function(message){
        var aNodeList = document.getElementsByTagName('a');

        for (var i = 0; i < aNodeList.length; i++) {
          if(aNodeList[i].getAttribute('data-value') == message.tabName) {
            if(message.action == 'hide'){
              aNodeList[i].setAttribute('style', 'display: none;');
            } else {
              aNodeList[i].setAttribute('style', 'display: block;');
            };
          };
        }
      });
    "))),
  sidebarMenu(
    id ="tabs",
    #fileiput variable from the fileinput.R file
    fileinput,
    # checkboxInput(inputId = "header",label = "header",value = FALSE),
    # checkboxInput(inputId = "stringAsFactors",label = "stringAsFactors",value = FALSE),
    # radioButtons(inputId = "sep",label = "Separator",choices = c(Comma=",",Semicolon=";",Tab="\t",Space=" " ),selected = ","),
    menuItem("Home", tabName = "home", icon = icon("dashboard")),
    menuItem("Analysis", tabName = "analysis", icon = icon("bar-chart-o"),
             menuSubItem("View Data", tabName = "viewData"),
             menuSubItem("Analysis Types", tabName = "analysisTypes"),
             menuSubItem("Visualisations", tabName = "visualisations")),
    
    menuItem("Prediction", tabName = "prediction", icon = icon("th"),
             menuSubItem("Data for prediction", tabName = "predictionData"),
             menuSubItem("Prediction Types", tabName = "predictionTypes")),
    menuItem("Create Account",tabName = "createAccount",icon = icon("log-in", lib = "glyphicon")),
    #menuItem(tags$a("Blog",href="https://ugdatabot.wordpress.com",target="_blank"),tabName = "blog",icon=icon("new-window",lib = "glyphicon"))
    menuItem("Log in",tabName = "login",icon = icon("log-in", lib = "glyphicon")),
    menuItem("Log out",tabName = "logout",icon = icon("log-out", lib = "glyphicon"))
  )
)
