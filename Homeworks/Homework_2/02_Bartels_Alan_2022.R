library(dplyr)
library(readr)
library(ggplot2)
library(forcats)
library(ggridges)

theme_set(theme_bw(base_size=12))

ice <- read_csv("http://biol607.github.io/homework/data/NH_seaice_extent_monthly_1978_2016.csv") %>%
  mutate(Month_Name = factor(Month_Name),
         Month_Name = fct_reorder(Month_Name, Month))


head(ice)

ice_extent <- ggplot(data = ice, 
                     mapping = aes(group = Month_Name,
                                   x = Extent,
                                   y = Month_Name))
ice_extent + geom_boxplot(fill = "turquoise")

ice_extent + geom_density_ridges(fill = "turquoise")

cut_interval(1:10, n = 5)

annual_ice_extent <- ggplot(data = ice, 
                            mapping = aes(
                              group = Year,
                              x = Month_Name,
                              y = Extent
                            ))
annual_ice_graph <- annual_ice_extent + geom_line()

annual_ice_graph

ice_by_month <- ggplot(data = ice, 
                       mapping = aes(
                         group = Month_Name,
                         x = Year,
                         y = Extent
                       ))
ice_by_month <-ice_by_month + geom_line()

ice_by_month + facet_wrap(vars(cut_interval(Month, n = 4)), 
                          labeller = "label_both"
                          )
   

                