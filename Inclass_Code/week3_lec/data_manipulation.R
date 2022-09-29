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



surveys |> mutate(hindfoot_cm = hindfoot_length * 0.1) |>
  select(species_id, hindfoot_cm) |> 
  filter(!is.na(hindfoot_cm)) |> filter(hindfoot_cm < 3)

visdat::vis_dat(surveys_hindfoot_cm)
summary(surveys)

# if we REally want detail about our data
skimr::skim(surveys$hindfoot_length)


#### Split -- Apply -- Combine ####

# What is the average weight of a rodent by sex?
# This is NOT QUITE what we want
surveys |> 
  group_by(sex) |>
  mutate(mean_weight = mean(weight, na.rm = TRUE))|>
  pull(mean_weight)

# This is what we want
surveys |> 
  group_by(sex) |> 
  summarize(mean_weight = mean(weight, na.rm = TRUE))

surveys |>
  filter(!is.na(weight)) |> 
  group_by(sex) |>
  summarize(mean_weight = mean(weight))

# Let's say we want the mean and minimum of weight by species and sex and then
# sort by minimum

# start with surveys 
# filter out weights
# group by species and sex
# calculate mean and min weights
# ARRANGE by minimum
surveys |> 
  filter(!is.na(weight)) |>
  group_by(sex, species_id) |>
  summarize(mean_weight = mean(weight),
            min_weight = min(weight))|>
           # .groups = "drop")
           #ungrouping methods
           ungroup() |>
  # Arrange by minimum
  arrange(min_weight, mean_weight) #also try arrange(desc(min_weight))

#### What if you jsut want to COUNT things ####
surveys |>
  group_by(sex, species_id) |>
  summarize(count = n())

# more compact 
surveys |>
  count(sex, species_id)


# why use ungroup 
# let's say we wanted to look at
# how each species/sex combination's minimum wegiht
# differed fromt eh SMALLEST minimum weight int eh whole data set
surveys |> 
  filter(!is.na(weight)) |>
  group_by(species_id, sex) |>
  summarize(mean_weight = mean(weight, na.rm = TRUE),
            min_weight = min(weight, na.rm = TRUE)) |>
  mutate(deviation_of_min = min_weight - min(min_weight))

# 1. How many animals were caught in each plot_type surveyed
str(surveys)
surveys |> count(plot_type)
# 2. Use group_by() and summarise() to find the mean, min, and max hindfoot 
# length for each species (using species_id) also add the number of observations
# of each species 
surveys |> group_by(species_id) |>
  summarize(mean_hf = mean(hindfoot_length, na.rm = TRUE),
            min_hf = min(hindfoot_length, na.rm = TRUE),
            max_hf = max(hindfoot_length, na.rm = TRUE),
            count = n())|> print(n = 48)
# 3. What was the heaviest animal measured in each year? Returns the columns year,
# genus, species_id and weight
surveys |> group_by(year, genus, species_id) |> 
  summarize(genus, species_id, weight = max(weight, na.rm = TRUE)) |>
  ungroup() |> group_by(year) |> summarize(genus, species_id, weight)

# Answer to problem 3
surveys |> filter(!is.na(weight)) |>
  group_by(year) |>
  filter(weight == max(weight)) |>
  select (year, genus, species_id, weight) |>
  ungroup() |>
  arrange(year)

            