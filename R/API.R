library(plumber)

users <- data.frame(
  uid = c(12,13),
  username = c("kim", "john")
)

#' @get /users/<id>
function(id) {
  subset(users, uid==id)
}

#' @get /type/<id>
function(id) {
  list(
    id=id, 
    type=typeof(id)
    )
}
