#' -------------------------------------------------------------------
#' Loading in Data and other Misc. 
#' 
#' @date 2022-09-20
#' -------------------------------------------------------------------

# What directory does R think it is in ? ####
getwd()
#setwd()

# look around a bit more
list.files()

# Let's look HERE
library(here)
here()

# This will set my working directory to where the Rproj file is
setwd(here::here())

#### Different ways to load data ####
my_data <- read.csv("data/my_dataset_clean.csv")

str(my_data)
my_data$column_3

# use something else to load data
library(readr) # makes a tibble NOT a D.F. 
my_data_readr <- read_csv("data/my_dataset_clean.csv")

library(vroom)
my_data_vroom <- vroom("data/my_dataset_clean.csv", delim = ",")

# load straight from excel
library(readxl)
#library(googlesheets4)
my_data_excel <-read_excel("data/my_dataset_testa.xlsx", sheet = 1) # takes sheet name or number
str(my_data_excel)
