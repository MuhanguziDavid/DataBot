options(mysql = list(
  "host" = "127.0.0.1",
  "port" = 3306,
  "user" = "root",
  "password" = ""
))
databaseName <- "databot"
table <- "eta"

insertUser <- function(username,password) {
  # Connect to the database
  db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
                  port = options()$mysql$port, user = options()$mysql$user, 
                  password = options()$mysql$password)
  # Construct the update query by looping over the data fields
  
  # query <- sprintf(
  #   "INSERT INTO %s (%s) VALUES ('%s')",
  #   table,
  #   c("password","username"),
  #   c(paste(username),paste(password))
  #   # paste(c("username","password"),collapse = ","),
  #   # paste(c(paste(username),paste(password)),collapse = ",")
  #   #paste(names(data), collapse = ", "),
  #   #paste(data, collapse = "', '")
  # )
  query<-paste(c("INSERT INTO eta(username,password) VALUES('",paste(username),"','",paste(password),"')"),collapse = "")
  #query<-"INSERT INTO user(username,password) VALUES('userna','pass')"
  # Submit the update query and disconnect
  dbGetQuery(db, query)
  dbDisconnect(db)
}

# loadData <- function() {
#   # Connect to the database
#   db <- dbConnect(MySQL(), dbname = databaseName, host = options()$mysql$host, 
#                   port = options()$mysql$port, user = options()$mysql$user, 
#                   password = options()$mysql$password)
#   # Construct the fetching query
#   query <- sprintf("SELECT * FROM %s", table)
#   # Submit the fetch query and disconnect
#   data <- dbGetQuery(db, query)
#   dbDisconnect(db)
#   data
# }
