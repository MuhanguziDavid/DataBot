fileinput <- fileInput("file", "Choose CSV File",
          multiple = TRUE,
          accept = c("text/csv",
                     "text/comma-separated-values,text/plain",
                     ".csv"))