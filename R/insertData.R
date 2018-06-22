options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3306,
  "user" = "root",
  "password" = ""
))
databaseName <- "databot"
table <- "eta_data"

insertTrainSet <- function(trainSet) {
  if (is.null(userName)){
    return(NULL)
  }
  # Connect to the database
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  
  # query <- paste(c("INSERT INTO eta(username,password) VALUES('",paste(username),"','",paste(password),"')"),collapse = "")
  # dbGetQuery(db, query)
  dbWriteTable(db, name="eta_data", value=trainSet, 
               overwrite=FALSE, 
               append=TRUE,
               row.names=FALSE)
  query <- paste(c("SELECT timestamp, open, high, low, close, adjusted_close, volume, username, ticker_Symbol FROM eta_data GROUP  BY timestamp, username, ticker_Symbol"),collapse = "")
  mergeRecords <- dbGetQuery(db, query)
  dbDisconnect(db)
  mergeRecords
  return(TRUE)
}
