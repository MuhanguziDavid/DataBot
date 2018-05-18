renderfile<-function(input,output){
  data<-reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    read.table(file = file1$datapath,sep = ",",header = TRUE)
  })
  
  output$filedf<-renderTable({
    if(is.null(data())){return()}
    input$file
  })
  output$summary<-renderDataTable({
    if(is.null(data())){return()}
    summary(data())
  })
  output$table<-renderDataTable({
    if(is.null(data())){return()}
    data()
  })
  output$contents<-renderUI({
    if(is.null(data()))
      h5("No Uploaded Data")
    else
      tabsetPanel(id = "dataTabs",tabPanel("About",tableOutput("filedf")),tabPanel("Data",dataTableOutput("table")),tabPanel("Summary",dataTableOutput("summary")))
  })
  
}
