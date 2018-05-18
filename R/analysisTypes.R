# source("renderVisualisation.R")

#links to server
# renderAnalysisTypes<-function(input, output, session){
#   
#   observeEvent(
#     eventExpr = input[["toHistogram"]],
#     handlerExpr = {
#       
#       updateTabItems(session, "tabs", selected = "visualisations")
#       # updateTabsetPanel(session, "plotTabs", selected = "Plot_2")
#       
#     })
#   
# }

#the UI part
#redirect to histogram
histogramType <- div(HTML(
  
  "<h1>Data Distributions</h1>",
  "<p>Here, the type of analysis carried out is frequency distributuion. THis shows how often each different value in a dataset occurs.</p>",
  "<p>A histogram is used to show the data distributions</p>"),
  
  actionButton(inputId ="toHistogram", label = "Go to Histogram"))

#redirect to second visulization
type2<-HTML(
  "<h1>THis is the second type of anaysis</h1>")

analysisTypes<-tabsetPanel(
  id="analysisTypesTabs",type="tabs" ,
  tabPanel(title = "Data Distribution",histogramType,value = "histogramType"),
  tabPanel(title = "Type2", type2, value = "type2"))