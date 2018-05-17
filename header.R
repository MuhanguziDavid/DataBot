blog<-tags$li("BLOG",href="https://ugdatabot.wordpress.com",target="_blank")
menu<-dropdownMenu(type = "tasks", badgeStatus = "success",
             taskItem(value = 90, color = "green",
                      "Documentation"
             ),
             taskItem(value = 17, color = "aqua",
                      "Project X"
             ),
             taskItem(value = 75, color = "yellow",
                      "Server deployment"
             )
)
header <- dashboardHeader(title = "DataBot",menu)
