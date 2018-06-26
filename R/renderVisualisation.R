
renderVisualisation <- function(input, output, session){
  # renderfile(input = input,output = output)

  observeEvent(c(input$submitlogin, input$file),
    handlerExpr = {
      if(is.null(dataUploaded)){
        if(is.null(userName)){
          h5("No Uploaded Data")
        }
        else{
          infile3 <- analysisData
          dirtyData3 <- na.omit(infile3)
          cleanData <- dirtyData3
          cleanDataHead <- head(cleanData,500)
          numericData <- cleanDataHead[,sapply(cleanData,is.numeric)]
          cleanDataHead$timestamp <- format(as.POSIXct(strptime(as.character(cleanDataHead$timestamp), "%m/%d/%Y")), "%y-%b-%d")
        }
      }
      else{
        getFileInput <- input$file
        if(is.null(getFileInput)){return()}
        uncleanedData <- read.csv(file = getFileInput$datapath, header = TRUE, sep = ",")
        cleanData <- na.omit(uncleanedData)
        cleanDataHead <- head(cleanData,500)
        numericData <- cleanDataHead[,sapply(cleanData,is.numeric)]
        cleanDataHead$timestamp <- format(as.POSIXct(strptime(as.character(cleanDataHead$timestamp), "%m/%d/%Y")), "%y-%b-%d")
      }
      
      xAxisLabel <- input$x3
      #print(xAxisLabel)
      
      output$Hist <- renderPlotly({
        plot <- numericData %>%
          plot_ly (x = ~get(input$x3), type = "histogram")
        plot
      })
      
      output$candleStick <- renderPlotly({
        
        plot <- cleanDataHead %>% 
          plot_ly(x=~timestamp, type = "candlestick",
                           open = ~open, close = ~close,
                           high = ~high, low = ~low) %>%
          add_lines(x = ~timestamp, y = ~open, line = list(color = 'black', width = 0.75), inherit = F) %>%
          layout(
            showlegend = FALSE,
            xaxis = list(
              nticks = 5
            ))
        plot
      })
      
      output$ohlc <- renderPlotly({
        plot <- cleanDataHead %>% 
          plot_ly(x=~timestamp, type = "ohlc",
                  open = ~open, close = ~close,
                  high = ~high, low = ~low) %>%
          layout(
            title = "OHLC Chart",
            showlegend = FALSE,
            xaxis = list(
              nticks = 5
            ))
        plot
      })
      
      output$fileName_analysis<-renderTable({
        if(is.null(dataUploaded)){
          analysisData$ticker_Symbol[1]
        }
        else{
          getFileInput$name
        }
      })
   
      visualizationTypes <- tabsetPanel(
        id = "plotTabs",
        tabPanel(
          "Histogram",
          fluidRow(
            column(width = 3,
                   box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                       tableOutput("fileName_analysis"),
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
                       tableOutput("fileName_analysis"),
                       h5("X: Date"),
                       h5("y: Open, High, Low, close")
                   ),
                   box(title = "Description", width = NULL, status = "primary", solidHeader = TRUE,
                       div(HTML(
                         "<h1>Candle sticks</h1>",
                         "<p>This chart displays the high, low, opening and closing prices of a security for each day. 
                         The wide part of the candlestick is called the real body and tells investors whether the closing price was higher or lower than the opening price. 
                         Black/red indicates that the stock closed lower and white/green indicates that the stock closed higher.</p>",
                         "<p>The line graph added shows the adjusted closing price for each day</p>"))
                   )),
            
            column(
              width = 9,
              box(title = "Candle Stick", width = NULL, status = "primary", solidHeader = TRUE,
                  withSpinner(plotlyOutput("candleStick"))
              ))
            
            )
          ),
        tabPanel(
          "OHLC",
          fluidRow(
            column(width = 3,
                   box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
                       tableOutput("fileName_analysis"),
                       h5("X: Date"),
                       h5("y: Open, High, Low, close")
                   ),
                   box(title = "Description", width = NULL, status = "primary", solidHeader = TRUE,
                       div(HTML(
                         "<h1>OHLC</h1>",
                         "<p>This chart shows the opening, high, low, and closing price of a company's stocks for a day.</p>",
                         "<p>Each vertical line on the chart shows the price range (the highest and lowest prices) for the day. 
                         Tick marks project from each side of the line indicating the opening price on the left, and the closing price for the day on the right. 
                         The bars are shown in green when the prices rose and in red when the prices dropped.</p>"))
                   )),
            
            column(
              width = 9,
              box(title = "Time Series", width = NULL, status = "primary", solidHeader = TRUE,
                  withSpinner(plotlyOutput("ohlc"))
              ))
            
            )
          )
      )
      #function to be used in body.R so as to output the plot
      output$visualizationOutput<-renderUI({
        if(is.null(dataUploaded)){
          if(is.null(userName)){
            h5("No Uploaded Data")
          }
          else{
            visualizationTypes
            # h5("logged in database data")
          }
        }
        else{
          visualizationTypes
          # h5("uploaded data")
        }
      })
      
    })
}
