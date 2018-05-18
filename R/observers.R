

observeEvent(input$submit, {
  updateTabsetPanel(session, "createAccountTabs",
                    selected = "instructions")
})

observeEvent(input$file, {
  updateTabItems(session, "tabs",
                 selected = "viewData")
})

#from analysisTypes.R
observeEvent(
  eventExpr = input[["toHistogram"]],
  handlerExpr = {
    
    # updateTabItems(session, "tabs", selected = "visualisations")
    updateTabsetPanel(session, "plotTabs", selected = "Plot_2")
    
  })