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
    output$confirmInsert<-renderUI({
      verticalLayout(
        HTML(
          ""))
    })
    
    updateTabItems(
      session, "tabs",
      selected = "viewData")
  })
  
  observeEvent(
    eventExpr = input[["save_to_database"]],
    handlerExpr = {
      infile3 <- input$file
      if(is.null(infile3)){return()}
      dirtyData3 <- read.csv(file = infile3$datapath, header = TRUE, sep = ",")
      cleanData<-na.omit(dirtyData3)
      
      cleanData$timestamp <- cleanData[order(as.Date(cleanData$timestamp, format="%m/%d/%Y")),]
      trainSet <- cleanData$timestamp
      # trainSet$eta_id <- "2"
      trainSet$username <- userName
      # trainSet$company_id <- "1"
      trainSet$ticker_Symbol <- infile3$name
      trainSet$dividend_amount <- NULL
      trainSet$split_coefficient <- NULL
      
      if (isTRUE(insertTrainSet(trainSet))){
        output$confirmInsert<-renderUI({
          verticalLayout(
            HTML(
              "<p>File Saved</p>"))
        })
      }
      else{
        output$confirmInsert<-renderUI({
          verticalLayout(
            HTML(
              "<p>File not saved. Please login and try again</p>"))
        })
      }
    })
  
  observeEvent(input$submitlogin,{
    if(is.null(retrieveUser(input$usernamelogin,input$passwordlogin))){
      updateTabsetPanel(session,"tabs",selected = "login")
        output$nouser<-renderUI({
          h5("Wrong Credentials")
        })
      }
    else{
      updateTextInput(session, "usernamelogin", value = "")
      updateTextInput(session, "passwordlogin", value = "")
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "login"))
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "createAccount"))
    
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "logout"))  
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "predictionData"))
    session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "predictionTypes"))
    
    updateTabsetPanel(session,"tabs",selected = "home")
    }
    
  })
  
  observeEvent(input$tabs,{
    if(input$tabs=="logout"){
      userName <<- NULL
      session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "login"))
      session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "display", tabName = "createAccount"))  
      session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "logout"))
      
      session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "predictionData"))
      session$sendCustomMessage(type = "manipulateMenuItem", message = list(action = "hide", tabName = "predictionTypes"))
      
      updateTabItems(
        session, "tabs",
        selected = "home")
    }
  })
}
