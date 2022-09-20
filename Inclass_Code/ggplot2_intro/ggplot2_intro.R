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
library(ggdist)
library(ggthemes)

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

#geom_point
bill_dist_xy +
  geom_point()

#geom_violin
bill_dist_xy +
  geom_violin()

#geom_boxplot
bill_dist_xy +
  geom_boxplot() +
  geom_jitter(size=3,
              alpha =0.3)

#geom_point
bill_dist_xy +
  geom_point()

#geom_violin
bill_dist_xy +
  geom_violin()

#stat_summary
bill_dist_xy + 
  stat_summary(size = 0.1)

#geom_density_ridges
bill_dist_xy +
  geom_density_ridges(aes(fill = species), alpha = 0.5)

#geom_density_ridges
bill_dist_xy +
  geom_density_ridges(alpha = 0.5, mapping = aes(fill = species))

#geom_slabinterval
bill_dist_xy + 
  geom_dotsinterval(side = 'bottom', aes(fill = 'black'), alpha = 0.5) +
  stat_halfeye(aes(fill = species),alpha = 0.5)

# Stat - summarizes or calculates something behind the scenes
ggplot(data = penguins,
        aes(x = species, y = bill_depth_mm, color = species)) + 
  stat_summary(fun.data = "mean_sdl",
               geom = "linerange", size = 4,
               color = "black") +
  stat_summary(fun.data = "mean_se")


#### Scatterplots ####

pen_mass_length <- 
  ggplot(data = penguins,
         mapping = aes(x = body_mass_g,
                       y = bill_length_mm,
                       color = species))

# basic scatter
pen_scatter <-  pen_mass_length + 
  geom_point(alpha = 0.6)

pen_scatter

#### Facet by data property ####
pen_scatter + facet_wrap(vars(species))


pen_scatter +
  facet_wrap(vars(species, sex))

#facet_grid
pen_scatter + facet_grid(vars(island, species))

#facet 
pen_scatter + 
  facet_grid(rows = vars(island),
             cols = vars(species))

ggplot(data = penguins, 
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm,
                     color = sex)) +
  geom_point() +
  facet_grid(rows = vars(island),
             cols = vars(species))

# facets and scales
pen_scatter + facet_wrap(vars(species),
                         scales = "free_y")

# removing NAs
penguins_clean <- penguins[!is.na(penguins$bill_depth_mm),]

#### Add a little spice ####

pen_scatter

## LABS()
#' Publication Quality-ify this graph
#' add a title
#' rename axes
#' captions
pen_scatter_beautiful <-  pen_scatter + 
  labs(title = "Penguin Bill Length by Mass",
       subtitle = "Data from Palmer LTER",
       x = "Body Mass (g)",
       y = "Bill length (m)",
       color = "Species of\nPenguin")


# redundant coding with shape
pen_scatter_beautiful <- pen_scatter_beautiful +
  aes(shape = species) +
  labs(shape = "Species of\nPenguin")

# make it colorblind friendly
pen_scatter_beautiful+ 
  scale_color_manual(values = c("red", "blue", "orange"))

pen_scatter_beautiful +
  scale_color_brewer(type = "qual")

pen_scatter_beautiful +
  scale_color_brewer(palette = "Dark2")

pen_scatter_beautiful <- pen_scatter_beautiful +
  ggthemes::scale_color_colorblind()

# whole package of themes
pen_scatter_beautiful + 
  ggthemes::theme_excel()

pen_scatter_beautiful +
  theme_minimal(base_size = 16, 
                base_family = "Papyrus") 
 # theme(panel.background = element_rect(fill = "blue"))

# continuous scales

pen_scatter + 
  aes(color = bill_depth_mm) +
  scale_color_viridis_c()

#### Stats ####
pen_mass_length +
  geom_point()

pen_mass_length +
  stat_smooth()

pen_mass_length +
  stat_smooth(method = "lm") +
  geom_point()

ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  stat_bin_2d()

ggplot(data = penguins,
       mapping = aes(x = body_mass_g,
                     y = bill_length_mm)) +
  stat_density_2d_filled()


# Load the bigfoot data
# explore what is there

#### Bigfoot ####

# Or read in the data manually

bigfoot <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-09-13/bigfoot.csv')
head(bigfoot)
str(bigfoot)
summary(bigfoot)

ggplot(data = bigfoot, mapping = aes(x = date, y = uv_index, )) + geom_point()


