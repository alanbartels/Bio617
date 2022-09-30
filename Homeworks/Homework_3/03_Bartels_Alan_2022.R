#' ---------------------------------------------------------------------------
#' HW3 R script
#' Alan Bartels
#' 
#' @date 2022-09-29
#' ---------------------------------------------------------------------------

library(dplyr)
library(readr)
library(ggplot2)
library(vroom)


keen_data <- read_csv("https://github.com/kelpecosystems/observational_data/blob/master/cleaned_data/keen_cover.csv?raw=true")


my_data_vroom <- vroom("data/keen_cover.csv", delim = ",")
