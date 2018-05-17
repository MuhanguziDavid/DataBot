loginpage<- mainPanel(
  textInput(inputId = "usernamelogin", label = "Username:"),
  passwordInput(inputId = "passwordlogin", label = "Password:"),
  actionButton(inputId ="submitlogin", label = "SUBMIT"),
  uiOutput("nouser")
)
