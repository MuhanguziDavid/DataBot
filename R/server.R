library(plotly)
library(ggplot2)
library(DT)
library(RMySQL)
library(MASS)
library(tseries)
library(forecast)

source("renderfile.R")
source("insertUser.R")
source("retrieveUser.R")
source("observer.R")
source("observers.R")
source("renderVisualisation.R")
source("predictions.R")
source("insertData.R")
source("retrievePredictionData.R")

options(shiny.maxRequestSize = 9*1024^2)

server <- function(input, output, session) {
  
  session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "logout"))
  session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "predictionData"))
  session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "predictionTypes"))
  observer(input = input,output = output,session = session)
  
  #set the login check to null
  userName <<- NULL
 
  renderfile(input=input,output=output)  
  renderVisualisation(input=input,output=output, session=session) 
  renderPrediction(input=input,output=output, session=session)
  renderPredictionData(input=input,output=output)
}
