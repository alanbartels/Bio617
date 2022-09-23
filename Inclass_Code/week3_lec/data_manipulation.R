#' ---------------------------------------------------------------------------
#' Data mainpulation with dplyr and tidyr
#' 
#' @date 2022-09-22
#' ---------------------------------------------------------------------------


#### Loading some libraries ####
library(dplyr) # data manipulation
library(tidyr) # reshaping tidy data
library(readr) # read in some data

#### Load in data ####
# load up data/combined.csv

surveys <- read.csv("./data/combined.csv")

#### Look at the data ####

head(surveys)
str(surveys)
visdat::vis_dat(surveys)

#### SELECTing certain columns ####

# we want the plot_id, species_id, and weight column 
select(surveys, plot_id, species_id, weight)

# equivalent subset
surveys[,c("plot_id", "species_id", "weight")]

# with a pipe
surveys |>
  select(plot_id, species_id, weight)

# remove record_id and species_id from surveys
surveys |>
  select(-record_id, -species_id) # use '-' to get rid of things

#### What if we want to FILTER the dataset down ####

# We want only 1995 data
surveys[surveys$year == 1995,]

surveys_1995 <- surveys |> 
  filter(year == 1995)

#### We can now build complex data manipulation pipelines ####

# we want to create an object where weight is less than five grams
# and we only have species_id, sex, and weight
surveys_small <- surveys |> 
  filter(weight < 5) |> 
  select(species_id, sex, weight)
surveys_small

#### EXERCISE ####
# Subset surveys to include animals collected before 1995 and only give back 
# year, sex, and weight

surveys_1995b <- surveys |>
  filter(year < 1995) |>
  select(year, sex, weight)
# select(year, sex, weight, everything()) # just reorder
surveys_1995b

# able to interrogate intermediate stages of a pipeline by -> to an objec

#defensive test programming
surveys <- surveys |>
  select(everything())

#### What if you want to change or create a new Value? ####
# we want to add a column weight_kg
surveys$weight_kg <- surveys$weight /1000

# MUTATE your way
surveys <- surveys |>
  mutate(weight_kg = weight/1000,
         weight_lb = weight_kg * 2.2) |> 
  # pull lets you extract a single column as a vector to debug and check yourself
  pull(weight_lb)



surveys |> select(species_id, hindfoot_length) |>
  mutate(hindfoot_cm = hindfoot_length * 0.1) |> 
  filter(-is.na(surveys)) -> int_surveys
  #filter(hindfoot_cm < 3)

