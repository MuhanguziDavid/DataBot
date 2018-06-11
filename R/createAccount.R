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
    paste(c("<h1>Created Account as: ",paste(textOutput("username")),"</h1>"))
    ),
  HTML(
    "<h2><br/>Instructions on integration</h2>",
    "<p>Please acquire the DataBot API and install it to be able to send data to the DataBot database</p>"
  )
  
 
)
createAccount<-tabsetPanel(
  id="createAccountTabs",type="tabs" ,
  tabPanel(title = "Credentials",credentials,value = "credentials"),
  tabPanel(title = "Instructions",instructions,value = "instructions"))
