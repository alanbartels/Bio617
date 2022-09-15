#' ----------------------------------------------------------------------------
#' Ggplot2 intro with palmerpenguins
#' 
#' @date 2022-09-15
#' ----------------------------------------------------------------------------

#### Libraries ####
library(ggplot2)
library(palmerpenguins)
library(visdat)
library(ggridges)

# how to run a function from a library without loading it
visdat::vis_miss(penguins)

#### Let's look at data penguins ####
head(penguins)
str(penguins)
summary(penguins)
vis_dat(penguins)


#### Our first ggplot ####
# aes - takes different aesthetic properties of a figure and mapps it onto a dataset
# 
bill_dist <- ggplot(data = penguins, 
                    mapping = aes(x = bill_length_mm))

class(bill_dist)
str(bill_dist)

# look at our masterpiece
bill_dist

## ggplot2 allows for adding layers of information. Allows for quick additions
## and removals, and you can make 2 different plots with same base info

# add a geom_()
bill_dist + 
  geom_histogram(bins = 20)
# fill color alpha
bill_dist +
  geom_density(fill = "grey", color = "red", alpha = 0.5 )

#### Visualizing multiple distributions ####
bill_dist_byspecies <- ggplot(data = penguins,
                              mapping = aes(x = bill_length_mm,
                                            group = species))
bill_dist_byspecies + 
  geom_density()

# add fill as an aesthetic
bill_dist_byspecies + 
  geom_density(mapping = aes(fill = species),
               alpha = 0.5)

# arguements for positioning
bill_dist_byspecies + 
  geom_density(mapping = aes(fill = species),
               alpha = 0.5,
               position_= "stack")

# Try geom_histogram
# arguements for positioning
bill_dist_byspecies + 
  geom_histogram(bins = 10, binwidth = 0.5, mapping = aes(fill = species), position = "identity", alpha = 0.5)

ggplot(data = penguins, aes(x = bill_length_mm, col = sex)) +
  geom_histogram(aes(fill = sex), alpha = 0.5, bins = 25) +
  facet_wrap(~species)

#### Visualizing two dimensions in space ####
bill_dist_xy <- ggplot(data = penguins,
                        mapping = aes(x = bill_length_mm,
                                      y = species,
                                      color = species))
#geom_point
bill_dist_xy +
  geom_point()

bill_dist_xy + 
  geom_point(size = 5, alpha = 0.1)

# OTOH - what about a jitter?
bill_dist_xy + 
  geom_jitter(size = 3, alpha = 0.5)
