# source(retrieveUser())

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
  
  observeEvent(input$submitlogin,{
      retrievePredictionData <- function() {
        # Connect to the database
        db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host,
                        port = options()$mysql$port, user = options()$mysql$user,
                        password = options()$mysql$password)
        
        # query<-paste(c("Select* from eta_data where username='",paste(userName),"'and ticker_Symbol='",paste(theCompanyId),"'"),collapse = "")
        query<-paste(c("SELECT DISTINCT ticker_Symbol FROM eta_data WHERE username='",paste(userName),"'"),collapse = "")
        predictionData <- dbGetQuery(db, query)
        
        dbDisconnect(db)
        predictionData <<- predictionData
        return(predictionData)
      }
      
      # predictionData_df <- retrievePredictionData()
      
      output$predictionDataTable<-renderDataTable({
        if(is.null(data())){return()}
        retrievePredictionData()
      })
      
      output$predictionDataOutput<-renderUI({
        # if(userName == 0)
        #   h5("Please Login")
        # else
          tabsetPanel(
            id = "dataTabs",
            tabPanel(
              "Prediction Data",
              dataTableOutput("predictionDataTable")),
            tabPanel("Data"))
      })
    })
      
  
}

