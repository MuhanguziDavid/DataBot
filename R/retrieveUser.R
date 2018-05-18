options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3306,
  "user" = "root",
  "password" = ""
))
databaseName <- "databot"
table <- "eta"

retrieveUser <- function(username,password) {
  # Connect to the database
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host,
                  port = options()$mysql$port, user = options()$mysql$user,
                  password = options()$mysql$password)
  # Construct the fetching query
  query<-paste(c("Select* from eta where username='",paste(username),"'and password='",paste(password),"'"),collapse = "")
  # Submit the fetch query and disconnect
  user <- dbGetQuery(db, query)
  
  dbDisconnect(db)
  if(length(user$id)>=1)
    return(user)
  else
  return(NULL)
}