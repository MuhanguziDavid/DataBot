renderVisualisation <- function(input, output, session){

  observeEvent(
    eventExpr = input$file,
    handlerExpr = {
      
      getFileInput <- input$file
      if(is.null(getFileInput)){return()}
      uncleanedData <- read.csv(file = getFileInput$datapath, header = TRUE, sep = ",")
      cleanData <- na.omit(uncleanedData)
      cleanDataHead <- head(cleanData,30)

      numericData <- cleanDataHead[,sapply(cleanData,is.numeric)]
      cleanDataHead$newDataHead <- as.POSIXct(strptime(as.character(cleanDataHead$timestamp), "%d/%m/%Y"))
      print(cleanDataHead$newDataHead)
      cleanDataHead$formatedTimeStamp <- format(cleanDataHead$newDataHead, "%Y-%m-%d")
      
      output$Hist <- renderPlotly({
        plot <- plot_ly (data = numericData, x = ~get(input$x3), type = "histogram")
        plot
      })
      
      output$candleStick <- renderPlotly({
        
        plot <- cleanDataHead %>% 
          plot_ly(x=~formatedTimeStamp, type = "candlestick",
                           open = ~open, close = ~close,
                           high = ~high, low = ~low) %>%
          layout(title = "CandleStick Chart")
        plot
      })
      
      output$timeSeries <- renderPlotly({
        plot <- cleanDataHead %>% 
          plot_ly(x=~formatedTimeStamp, type = "ohlc",
                  open = ~open, close = ~close,
                  high = ~high, low = ~low) %>%
          layout(title = "OHLC Chart")
        plot
      })
      
      visualizationTypes <- tabsetPanel(
        id = "plotTabs",
        tabPanel(
          "Histogram",
          fluidRow(
            column(width = 3,
                   box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                       selectInput(inputId = "x3", label = "x axis of Histogram:" ,choices = names(numericData))
                      
                   ),
                   box(title = "Description", width = NULL, status = "primary", solidHeader = TRUE,
                       div(HTML(
                         "<h1>Data Distributions</h1>",
                         "<p>Here, the type of analysis carried out is frequency distributuion. THis shows how often each different value in a dataset occurs.</p>",
                         "<p>A histogram is used to show the data distributions</p>"))
                   )),
            
            column(
              width = 9,
              box(title = "Histogram", width = NULL, status = "primary", solidHeader = TRUE,
                  withSpinner(plotlyOutput("Hist"))
              ))
            
          )
        ),
        tabPanel(
          "Candle Stick",
          fluidRow(
            column(width = 3,
                   box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                       selectInput(inputId = "x3", label = "x axis of the Candle Stick:" ,choices = names(cleanDataHead))
                       
                   ),
                   box(title = "Description", width = NULL, status = "primary", solidHeader = TRUE,
                       div(HTML(
                         "<h1>Data Distributions</h1>",
                         "<p>Here, the type of analysis carried out is frequency distributuion. THis shows how often each different value in a dataset occurs.</p>",
                         "<p>A histogram is used to show the data distributions</p>"))
                   )),
            
            column(
              width = 9,
              box(title = "Candle Stick", width = NULL, status = "primary", solidHeader = TRUE,
                  withSpinner(plotlyOutput("candleStick"))
              ))
            
            )
          ),
        tabPanel(
          "Time Series",
          fluidRow(
            column(width = 3,
                   box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                       selectInput(inputId = "x3", label = "x axis of the Time Series:" ,choices = names(cleanDataHead))
                       
                   ),
                   box(title = "Description", width = NULL, status = "primary", solidHeader = TRUE,
                       div(HTML(
                         "<h1>Data Distributions</h1>",
                         "<p>Here, the type of analysis carried out is frequency distributuion. THis shows how often each different value in a dataset occurs.</p>",
                         "<p>A histogram is used to show the data distributions</p>"))
                   )),
            
            column(
              width = 9,
              box(title = "Time Series", width = NULL, status = "primary", solidHeader = TRUE,
                  withSpinner(plotlyOutput("timeSeries"))
              ))
            
            )
          )
      )
      #function to be used in body.R so as to output the plot
      output$visualizationOutput<-renderUI({
        if(is.null(input$file))
          h5("No Uploaded Data")
        else
          visualizationTypes
      })
      
    })
}

