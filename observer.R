observer<-function(input,output,session){
  
  observeEvent(input$submit, {
    output$username<-renderText({
      paste(input$username)
    }) 
    output$password<-renderText({
      paste(input$password)
    }) 
    updateTabsetPanel(session, "createAccountTabs",
                      selected = "instructions")
    insertUser(input$username,input$password)
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "login"))
  })
  
  
  observeEvent(input$file, {
    updateTabItems(session, "tabs",
                   selected = "viewData")
  })
  
  observeEvent(input$submitlogin,{
    if(is.null(retrieveUser(input$usernamelogin,input$passwordlogin))){
      updateTabsetPanel(session,"tabs",selected = "login")
        output$nouser<-renderUI({
          h5("Wrong Credentials")
        })
      }
    else{
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "login"))
      session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "createAccount"))
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "logout"))  
    updateTabsetPanel(session,"tabs",selected = "home")
    }
    
  })
  
  observeEvent(input$tabs,{
    if(input$tabs=="logout"){
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "login"))
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "createAccount"))  
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "logout"))
    }
    
  })
}
