library(shiny)
library(shinydashboard)
library(plotly)
library(ggplot2)
library(shinycssloaders)
library(DT)
library(RMySQL)
library(MASS)
library(tseries)
library(forecast)

source("header.R")
source("sidebar.R")
source("body.R")
source("createAccount.R")
source("renderVisualisation.R")
source("predictions.R")

dashboardPage(header, sidebar, body)