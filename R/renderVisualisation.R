source("analysisTypes.R")

renderVisualisation<-function(input, output, session){
  
  observeEvent(
    eventExpr = input[["submit_loc"]],
    handlerExpr = {
      
      infile3 <- input$file
      if(is.null(infile3)){return()}
      dirtyData3 <- read.csv(file = infile3$datapath, header = TRUE, sep = ",")
      noNaData<-na.omit(dirtyData3)
      
      #select only numeric columns to use for the plot
      data3 <- noNaData[,sapply(noNaData,is.numeric)]
      
      #updates the list of columns to be selected for the plot
      updateSelectInput(session, "x3", choices = names(data3))
      
      xVarName <- input$x3
      
      output$myHist <- renderPlotly({
        # histogram()
        plot <- plot_ly (data3, x = ~get(input$x3), type = "histogram" )
        plot
      })
      
    })
  
  
  #function to be used in body.R so as to output the plot
  output$visualizationOutput<-renderUI({
    if(is.null(input$file))
      h5("No Uploaded Data")
    else
      visualizationTypes
  })
  
}

visualizationTypes <- tabsetPanel(
  id = "plotTabs",
  tabPanel(
    "Histogram",
    fluidRow(
      box(title = "Inputs", width = 3, status = "primary", solidHeader = TRUE,
        selectInput("x3", "x axis of Histogram:" ,"Select a field"),
        # sliderInput("bins", "2.Select the number of BINs for the histogram", min=10, max=200, value=100),
        
        actionButton(
          inputId = "submit_loc",
          label = "Plot")
        ),
      box(title = "Histogram", width = 9, status = "primary", solidHeader = TRUE,
        plotlyOutput("myHist")
        )
      )
  ),
  tabPanel("Plot_2","Another Plot"),
  tabPanel("Plot_3","Guess what, another plot :)")
)