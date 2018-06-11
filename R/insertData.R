options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3306,
  "user" = "root",
  "password" = ""
))
databaseName <- "databot"
table <- "eta_data"

insertTrainSet <- function(trainset) {
  # Connect to the database
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  
  # query <- paste(c("INSERT INTO eta(username,password) VALUES('",paste(username),"','",paste(password),"')"),collapse = "")
  dbWriteTable(db, name="eta_data", value=trainSet, 
               overwrite=TRUE, 
               append=FALSE,
               row.names=FALSE)
  # dbGetQuery(db, query)
  dbDisconnect(db)
}
