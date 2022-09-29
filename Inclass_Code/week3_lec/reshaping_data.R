#' ---------------------------------------------------------------------------
#' Reshaping data
#' 
#' @date 2022-09-23
#' ---------------------------------------------------------------------------


#### Loading some libraries ####
library(dplyr) # data manipulation
library(tidyr) # reshaping tidy data
library(readr) # read in some data

#### Load in data ####
# load up data/combined.csv

surveys <- read.csv("./data/combined.csv")
surveys


#### Let's make a dataset that is the mean weight of each genus in each plot ID ####
surveys_gw <- 
  surveys |>
  filter(!is.na(weight)) |>
  group_by(plot_id, genus) |>
  summarise(mean_weight = mean(weight)) |>
  ungroup()

# Let's pivot wide
surveys_gw_wide <- 
  surveys_gw |>
  pivot_wider(names_from = genus,
              values_from = mean_weight,
              values_fill = 0,
              names_prefix = "weight_") |> print()

# pivoting LONG
# pivot_longer you need quoted names for new columns
surveys_gw_long <- 
  surveys_gw_wide |> 
  pivot_longer(names_to = "measure_genus",
               values_to = "mean_weight",
               cols = -plot_id) |> print()

surveys |> 
  group_by(year, plot_id)|>
  summarize(year, plot_id, genera_per_plot = n_distinct(genus)) |>
  pivot_wider(names_from = year,
              values_from = genera_per_plot) |> print()

#answer
# make a new object
annual_genera <- 
  # start with survey, 
  surveys |>
  #for each year and plot, 
  group_by(plot_id, year) |>
  #get the unique number of genera
  summarize(num_genera = n_distinct(genus)) |>
  # then pivot wide with year as column
  pivot_wider(names_from = year,
              values_from = num_genera)

annual_genera_long <- 
  annual_genera |>
  pivot_longer(names_to = "year",
               values_to = "num_genera",
               cols = -plot_id)

# I want ot plot the average hindfoot_length per plot_id and plot_type
# against the AVERAGE weight
library(ggplot2)
ggplot(surveys,
       mapping = aes(x = hindfoot_length,
                     y = weight)) +
  geom_point()

lw_surveys <- surveys |>
  # we want to work with just these four variables
  select(plot_id, plot_type, hindfoot_length, weight) |>
# then filter out NAs
  filter(!is.na(hindfoot_length),
         !is.na(weight)) |>
  # pivot longer so that MEASUREMENT TYPE is a column
  pivot_longer(cols = c(hindfoot_length, weight),
               names_to = "measurement",
               values_to = "value") |>
  group_by(plot_id, plot_type, measurement) |>
  # and get averages
  summarize(mean_value = mean(value))

ggplot(lw_surveys,
       mapping = aes(x = plot_type,
                     y = mean_value)) +
  geom_jitter() + facet_wrap(vars(measurement), scale = "free")

# let's look at relationships
lw_wide <- 
  lw_surveys |>
  pivot_wider(names_from = measurement,
              values_from = mean_value)

ggplot(lw_wide,
       mapping = aes(x = hindfoot_length,
                     y = weight,
                     color = plot_type)) +
  geom_point()

