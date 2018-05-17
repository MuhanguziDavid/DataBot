library(plotly)
library(ggplot2)
library(DT)
library(RMySQL)
source("renderfile.R")
source("insertUser.R")
source("retrieveUser.R")
source("observer.R")
source("observers.R")
source("renderVisualisation.R")
source("analysisTypes.R")
options(shiny.maxRequestSize = 9*1024^2)

server <- function(input, output, session) {
  
  session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "logout"))
  observer(input = input,output = output,session = session)
 
  renderfile(input=input,output=output)  
  renderVisualisation(input=input,output=output, session=session) 
  renderAnalysisTypes(input=input,output=output, session=session)
}
