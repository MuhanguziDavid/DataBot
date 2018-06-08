
renderPrediction<-function(input, output, session){
  
  #ARIMA Observer
  observeEvent(
    eventExpr = input[["submit_arima"]],
    handlerExpr = {
      
      infile3 <- input$file
      if(is.null(infile3)){return()}
      dirtyData3 <- read.csv(file = infile3$datapath, header = TRUE, sep = ",")
      cleanData<-na.omit(dirtyData3)
      
      #train the model
      cleanData$timestamp <- cleanData[order(as.Date(cleanData$timestamp, format="%m/%d/%Y")),]
      traindata <- cleanData$timestamp
      trainset = traindata$adjusted_close
      
      trainset_ts <- ts(trainset, end = c(2018,156), frequency = 365)
      trainset_ts_arima <- auto.arima(trainset_ts)
      
      #get 5 forecasted values
      forecastedValues_arima = forecast(trainset_ts_arima, h=5)
      
      output$predictionTable_arima <- renderTable({
        (forecastedValues_arima)
      })
      
      output$predictionPlot_arima <- renderPlotly({
        # plot <- plot.ts(forecastedValues_arima)
        # plot
        plot_arima <- plot_ly() %>%
          add_lines(x = time(trainset_ts), y = trainset, 
                    color = I("black"), name = "observed") %>%
          add_ribbons(x = time(forecastedValues_arima$mean), ymin = forecastedValues_arima$lower[, 2], ymax = forecastedValues_arima$upper[, 2],
                      color = I("gray95"), name = "95% confidence") %>%
          add_ribbons(x = time(forecastedValues_arima$mean), ymin = forecastedValues_arima$lower[, 1], ymax = forecastedValues_arima$upper[, 1],
                      color = I("gray80"), name = "80% confidence") %>%
          add_lines(x = time(forecastedValues_arima$mean), y = forecastedValues_arima$mean, color = I("blue"), name = "prediction")
        plot_arima
      })
      
      output$forecastsPlot_arima <- renderPlotly({
        forecast_arima <- plot_ly() %>%
          add_ribbons(x = time(forecastedValues_arima$mean), ymin = forecastedValues_arima$lower[, 2], ymax = forecastedValues_arima$upper[, 2],
                      color = I("gray95"), name = "95% confidence") %>%
          add_ribbons(x = time(forecastedValues_arima$mean), ymin = forecastedValues_arima$lower[, 1], ymax = forecastedValues_arima$upper[, 1],
                      color = I("gray80"), name = "80% confidence") %>%
          add_lines(x = time(forecastedValues_arima$mean), y = forecastedValues_arima$mean, color = I("blue"), name = "prediction")
        forecast_arima
      })
      
    })
  
  #Holts Observer
  observeEvent(
    eventExpr = input[["submit_holts"]],
    handlerExpr = {
      
      infile3 <- input$file
      if(is.null(infile3)){return()}
      dirtyData3 <- read.csv(file = infile3$datapath, header = TRUE, sep = ",")
      cleanData<-na.omit(dirtyData3)
      
      #train the model
      cleanData$timestamp <- cleanData[order(as.Date(cleanData$timestamp, format="%m/%d/%Y")),]
      traindata <- cleanData$timestamp
      trainset = traindata$adjusted_close
      
      trainset_ts <- ts(trainset, end = c(2018,156), frequency = 365)
      trainset_ts_holts <- HoltWinters(trainset_ts, gamma=FALSE)
      
      #get 5 forecasted values
      forecastedValues_holts = forecast(trainset_ts_holts, h=5)
      
      output$predictionTable_holts <- renderTable({
        (forecastedValues_holts)
      })
      
      output$predictionPlot_holts <- renderPlotly({
        # plot <- plot.ts(forecastedValues_holts)
        # plot
        plot_holts <- plot_ly() %>%
          add_lines(x = time(trainset_ts), y = trainset, 
                    color = I("black"), name = "observed") %>%
          add_ribbons(x = time(forecastedValues_holts$mean), ymin = forecastedValues_holts$lower[, 2], ymax = forecastedValues_holts$upper[, 2],
                      color = I("gray95"), name = "95% confidence") %>%
          add_ribbons(x = time(forecastedValues_holts$mean), ymin = forecastedValues_holts$lower[, 1], ymax = forecastedValues_holts$upper[, 1],
                      color = I("gray80"), name = "80% confidence") %>%
          add_lines(x = time(forecastedValues_holts$mean), y = forecastedValues_holts$mean, color = I("blue"), name = "prediction")
        plot_holts
      })
      
      output$forecastsPlot_holts <- renderPlotly({
        forecast_holts <- plot_ly() %>%
          add_ribbons(x = time(forecastedValues_holts$mean), ymin = forecastedValues_holts$lower[, 2], ymax = forecastedValues_holts$upper[, 2],
                      color = I("gray95"), name = "95% confidence") %>%
          add_ribbons(x = time(forecastedValues_holts$mean), ymin = forecastedValues_holts$lower[, 1], ymax = forecastedValues_holts$upper[, 1],
                      color = I("gray80"), name = "80% confidence") %>%
          add_lines(x = time(forecastedValues_holts$mean), y = forecastedValues_holts$mean, color = I("blue"), name = "prediction")
        forecast_holts
      })
      
    })
  
  #Seasonal Adjustments observer
  observeEvent(
    eventExpr = input[["submit_ma"]],
    handlerExpr = {
      
      infile3 <- input$file
      if(is.null(infile3)){return()}
      dirtyData3 <- read.csv(file = infile3$datapath, header = TRUE, sep = ",")
      cleanData<-na.omit(dirtyData3)
      
      #train the model
      cleanData$timestamp <- cleanData[order(as.Date(cleanData$timestamp, format="%m/%d/%Y")),]
      traindata <- cleanData$timestamp
      trainset = traindata$adjusted_close
      trainset_ts <- ts(trainset, end = c(2018,156), frequency = 365)
      
      trainset_ma = ma(trainset, order=7)
      
      trainset_ma_ts <- ts(na.omit(trainset_ma), end = c(2018,156), frequency = 365)
      trainset_ma_ts_stl <- stl(trainset_ma_ts, s.window="periodic")
      trainset_ma_ts_stl_seasadj <- seasadj(trainset_ma_ts_stl)
      
      #get 5 forecasted values
      forecastedValues_ma = forecast(trainset_ma_ts_stl_seasadj, h=5)
      
      output$predictionTable_ma <- renderTable({
        (forecastedValues_ma)
      })
      
      output$predictionPlot_ma <- renderPlotly({
        # plot <- plot.ts(forecastedValues_ma)
        # plot
        plot_ma <- plot_ly() %>%
          add_lines(x = time(trainset_ts), y = trainset, 
                    color = I("black"), name = "observed") %>%
          add_ribbons(x = time(forecastedValues_ma$mean), ymin = forecastedValues_ma$lower[, 2], ymax = forecastedValues_ma$upper[, 2],
                      color = I("gray95"), name = "95% confidence") %>%
          add_ribbons(x = time(forecastedValues_ma$mean), ymin = forecastedValues_ma$lower[, 1], ymax = forecastedValues_ma$upper[, 1],
                      color = I("gray80"), name = "80% confidence") %>%
          add_lines(x = time(forecastedValues_ma$mean), y = forecastedValues_ma$mean, color = I("blue"), name = "prediction")
        plot_ma
      })
      
      output$forecastsPlot_ma <- renderPlotly({
        forecast_ma <- plot_ly() %>%
          add_ribbons(x = time(forecastedValues_ma$mean), ymin = forecastedValues_ma$lower[, 2], ymax = forecastedValues_ma$upper[, 2],
                      color = I("gray95"), name = "95% confidence") %>%
          add_ribbons(x = time(forecastedValues_ma$mean), ymin = forecastedValues_ma$lower[, 1], ymax = forecastedValues_ma$upper[, 1],
                      color = I("gray80"), name = "80% confidence") %>%
          add_lines(x = time(forecastedValues_ma$mean), y = forecastedValues_ma$mean, color = I("blue"), name = "prediction")
        forecast_ma
      })
      
    })
  
  
  #function to be used in body.R so as to output the plot
  output$predictionOutput<-renderUI({
    if(is.null(input$file))
      h5("No Uploaded Data")
    else
      predictionTypes
  })
  
}

predictionTypes <- tabsetPanel(
  id = "predictionTabs",
  tabPanel(
    "ARIMA",
    fluidRow(
      column(
        width = 6,
        box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
          actionButton(
            inputId = "submit_arima",
            label = "Predict"))
      ),
      column(
        width = 6,
        box(title = "Predicted Values", width = NULL, status = "primary", solidHeader = TRUE,
            tableOutput("predictionTable_arima")
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        box(title = "Prediction Plot", width = NULL, status = "primary", solidHeader = TRUE,
            withSpinner(plotlyOutput("predictionPlot_arima"))
        )
      ),
      column(
        width = 6,
        box(title = "Forecasts", width = NULL, status = "primary", solidHeader = TRUE,
            withSpinner(plotlyOutput("forecastsPlot_arima"))
        )
      )
    )
  ),
  
  tabPanel(
    "Holts_Winters",
    fluidRow(
      column(
        width = 6,
        box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
            actionButton(
              inputId = "submit_holts",
              label = "Predict"))
      ),
      column(
        width = 6,
        box(title = "Predicted Values", width = NULL, status = "primary", solidHeader = TRUE,
            tableOutput("predictionTable_holts")
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        box(title = "Prediction Plot", width = NULL, status = "primary", solidHeader = TRUE,
            withSpinner(plotlyOutput("predictionPlot_holts"))
        )
      ),
      column(
        width = 6,
        box(title = "Forecasts", width = NULL, status = "primary", solidHeader = TRUE,
            withSpinner(plotlyOutput("forecastsPlot_holts"))
        )
      )
    )
  ),
  
  tabPanel(
    "Seasonal_Adjustment",
    fluidRow(
      column(
        width = 6,
        box(title = "Inputs", width = NULL, status = "primary", solidHeader = TRUE,
            actionButton(
              inputId = "submit_ma",
              label = "Predict"))
      ),
      column(
        width = 6,
        box(title = "Predicted Values", width = NULL, status = "primary", solidHeader = TRUE,
            tableOutput("predictionTable_ma")
        )
      )
    ),
    fluidRow(
      column(
        width = 6,
        box(title = "Prediction Plot", width = NULL, status = "primary", solidHeader = TRUE,
            withSpinner(plotlyOutput("predictionPlot_ma"))
        )
      ),
      column(
        width = 6,
        box(title = "Forecasts", width = NULL, status = "primary", solidHeader = TRUE,
            withSpinner(plotlyOutput("forecastsPlot_ma"))
        )
      )
    )
  )
)
