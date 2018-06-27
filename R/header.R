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
#header <- dashboardHeader(title = "DataBot",menu,
    # Set height of dashboardHeader
 #   tags$li(class = "dropdown",
  #          tags$style(".main-header {max-height: 20px}"),
   #         tags$style(".main-header .logo {height: 20px;}"),
    #        tags$style(".sidebar-toggle {height: 20px; padding-top: 1px !important;}"),
     #       tags$style(".navbar {min-height:20px !important}")
    #) 
  #)
