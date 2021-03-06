
renderPredictionData<-function(input,output){
  options(mysql = list(
    "host" = "127.0.0.1",
    "port" = 3306,
    "user" = "root",
    "password" = ""
  ))
  databaseName <- "databot"
  table <- "eta_data"
  # theEta <- "mset"
  theCompanyId <- "Centenary"
  
  # retrievePredictionData(eta, CompanyId)
  
  observeEvent(c(input$submitlogin,input$save_to_database),{
    
      retrieveCompanyNames <- function() {
        # Connect to the database
        db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host,
                        port = options()$mysql$port, user = options()$mysql$user,
                        password = options()$mysql$password)
        
        # query<-paste(c("Select* from eta_data where username='",paste(userName),"'and ticker_Symbol='",paste(theCompanyId),"'"),collapse = "")
        query<-paste(c("SELECT DISTINCT ticker_Symbol FROM eta_data WHERE username='",paste(userName),"'"),collapse = "")
        companyNames <- dbGetQuery(db, query)
        
        dbDisconnect(db)
        companyNames <<- companyNames
        return(companyNames)
      }
      
      #data table for predicitons
      retrievePredictionData <- function() {
        # Connect to the database
        db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host,
                        port = options()$mysql$port, user = options()$mysql$user,
                        password = options()$mysql$password)
        
        query<-paste(c("Select* from eta_data where username='",paste(userName),"'and ticker_Symbol='",paste((toString(input$selectedCompanyName))),"'"),collapse = "")
        # query<-paste(c("SELECT DISTINCT ticker_Symbol FROM eta_data WHERE username='",paste(userName),"'"),collapse = "")
        predictionData <- dbGetQuery(db, query)
        
        dbDisconnect(db)
        predictionData <<- predictionData
        return(predictionData)
      }
      
      #data table for analysis
      retrieveAnalysisData <- function() {
        # Connect to the database
        db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host,
                        port = options()$mysql$port, user = options()$mysql$user,
                        password = options()$mysql$password)
        
        query<-paste(c("Select* from eta_data where username='",paste(userName),"'and ticker_Symbol='",paste((toString(input$selectedCompanyName_analysis))),"'"),collapse = "")
        # query<-paste(c("SELECT DISTINCT ticker_Symbol FROM eta_data WHERE username='",paste(userName),"'"),collapse = "")
        analysisData <- dbGetQuery(db, query)
        
        dbDisconnect(db)
        analysisData <<- analysisData
        # renderVisualisation(input=input,output=output, session=session)
        return(analysisData)
      }
      
      #table with values from DB to be used for predicitons
      output$predictionDataTable<-renderDataTable({
        # if(is.null(data())){return()}
        retrievePredictionData()
      })
      
      #table with values from DB to be used for analysis
      output$analysisDataTable_DB<-renderDataTable({
        # if(is.null(data())){return()}
        retrieveAnalysisData()
      })
      
      output$predictionDataOutput<-renderUI({
        # if(userName == 0)
        #   h5("Please Login")
        # else
          tabsetPanel(
            id = "dataTabs",
            tabPanel(
              "Prediction Data",
              fluidRow(
                column(
                  width = 3,
                  box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                      selectInput(inputId = "selectedCompanyName", label = "Choose company:" ,choices = retrieveCompanyNames()$ticker_Symbol)))),
              fluidRow(
                column(
                  width = 12,
                  box(title = "Company Data", width = NULL, status = "primary", solidHeader = TRUE,
                      dataTableOutput("predictionDataTable"))))))
      })
    })
      
  
}

