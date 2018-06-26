source("retrievePredictionData.R")

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
  
  dataUpload <- reactive({
    dataUploaded <<- data()
  })
  
  
  output$contents<-renderUI({
    if(is.null(dataUploaded)){
      if(is.null(userName)){
        h5("No Uploaded Data")
      }
      else{
        tabsetPanel(
          id = "dataTabsFromDB",
          tabPanel(
            "Analysis Data",
            fluidRow(
              column(
                width = 3,
                box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                    selectInput(inputId = "selectedCompanyName_analysis", label = "Choose company:" ,choices = retrieveCompanyNames()$ticker_Symbol)))),
            fluidRow(
              column(
                width = 12,
                box(title = "Company Data", width = NULL, status = "primary", solidHeader = TRUE,
                    dataTableOutput("analysisDataTable_DB"))))))
      }
    }
      
    else {
      tabsetPanel(
        id = "dataTabsDirect",
        tabPanel(
          "About",
          tableOutput("filedf"),
          fluidRow(
            actionButton(
              inputId = "save_to_database",
              label = "Save to Database"),
            actionButton(
              inputId = "analyze_db_data",
              label = "Database data")
          ),
          uiOutput("confirmInsert")),
        
        tabPanel("Data",
                 dataTableOutput("table")),
        tabPanel("Summary",
                 dataTableOutput("summary")))
    }
  })
  
}
