library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(DT)
library(RMySQL)
#UI Page where the user interfcae begins
#UI is created in dashboard format
#Dashboard main elements are header,sidebar and body
#these have been placed in different files titled with their respective names for code readability

#This page only needs this fucntion to initialise the dashboard page
#first we need to add the necessary files using the source function
#Add the header
source("header.R")
#Add the sidebar
source("sidebar.R")
#Add the body
source("body.R")
#Add Create Account
source("createAccount.R")
#Add visualization
source("renderVisualisation.R")
#add analysis types
source("analysisTypes.R")
dashboardPage(header, sidebar, body)