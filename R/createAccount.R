credentials<- mainPanel(
  textInput(inputId = "username", label = "Username:"),
  passwordInput(inputId = "password", label = "Password:"),
  actionButton(inputId ="submit", label = "SUBMIT")
  
)

# instructions<-HTML(
#   "<h1>Instructions here</h1>"
# )
instructions<-verticalLayout(
  HTML(
      "<h1>Instructions here</h1>"
    ),
  textOutput("username"),
   textOutput("password")
 
)
createAccount<-tabsetPanel(
  id="createAccountTabs",type="tabs" ,
  tabPanel(title = "Credentials",credentials,value = "credentials"),
  tabPanel(title = "Instructions",instructions,value = "instructions"))
