library(dplyr)
library(readr)
library(ggplot2)
library(forcats)
library(ggridges)
library(gganimate)
library(colorfindr)

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

annual_ice_extent <- ggplot(data = ice, 
                            mapping = aes(
                              group = Year,
                              x = Month_Name,
                              y = Extent,
                              color = Year
                            ))

annual_ice_graph <- annual_ice_extent + 
  geom_line() +
  scale_color_gradient(low = "turquoise", high = "black", 
                       limits = c(1978, 2016), 
                       guide = "none") +
  labs(title = "Arctic Sea Ice Size 1978-2016", 
       x = "Month", 
       y = "Sea Ice Extent",
       caption = "Data source: nsidc.org") +
  scale_y_continuous(breaks = 0:20) +
  theme_light()

annual_ice_graph

pallette <- get_colors("https://www.movieart.ch/bilder_xl/tintin-et-milou-poster-11438_0_xl.jpg") |>
  make_palette(n = (2016-1978))

annual_ice_graph <- annual_ice_extent + 
  geom_line() +
  labs(title = "Arctic Sea Ice Size 1978-2016", 
       x = "Month", 
       y = "Sea Ice Extent",
       caption = "Data source: nsidc.org") +
  scale_color_discrete(values = pallette)
  scale_y_continuous(breaks = 0:20) +
  theme_light()

annual_ice_graph

                