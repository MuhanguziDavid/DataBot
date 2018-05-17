library("RCurl")
library("rjson")

# Accept SSL certificates issued by public Certificate Authorities
options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))

h = basicTextGatherer()
hdr = basicHeaderGatherer()

req =  list(
  Inputs = list(
    "input1"= list(
      list(
        'quarter' = "1",
        'stock' = "",
        'date' = "",
        'open' = "",
        'high' = "",
        'low' = "",
        'close' = "",
        'volume' = "1",
        'percent_change_price' = "1",
        'percent_change_volume_over_last_wk' = "1",
        'previous_weeks_volume' = "1",
        'next_weeks_open' = "",
        'next_weeks_close' = "",
        'percent_change_next_weeks_price' = "1",
        'days_to_next_dividend' = "1",
        'percent_return_next_dividend' = "1"
      )
    )
  ),
  GlobalParameters = setNames(fromJSON('{}'), character(0))
)

body = enc2utf8(toJSON(req))
api_key = "abc123" # Replace this with the API key for the web service
authz_hdr = paste('Bearer', api_key, sep=' ')

h$reset()
curlPerform(url = "https://ussouthcentral.services.azureml.net/workspaces/83bde2acfb6b472591185bce485f8f80/services/3777c8d8cbec4541a84f5592927cee79/execute?api-version=2.0&format=swagger",
            httpheader=c('Content-Type' = "application/json", 'Authorization' = authz_hdr),
            postfields=body,
            writefunction = h$update,
            headerfunction = hdr$update,
            verbose = TRUE
)

headers = hdr$value()
httpStatus = headers["status"]
if (httpStatus >= 400)
{
  print(paste("The request failed with status code:", httpStatus, sep=" "))
  
  # Print the headers - they include the requert ID and the timestamp, which are useful for debugging the failure
  print(headers)
}

print("Result:")
result = h$value()
print(fromJSON(result))