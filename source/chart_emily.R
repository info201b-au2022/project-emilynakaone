library(dplyr)
library(tidyr)
library(ggplot2)

snowcrab_df <- read.csv("~/Documents/INFO201/project-emilynakaone/mfsnowcrab.csv")

crabhaul_df <- snowcrab_df %>% 
  select(year, haul) %>% 
  group_by(year) %>% 
  summarise(across(c(haul), sum)) 
  
scatterplot_chart <- ggplot(crabhaul_df, aes(x = year, y=haul)) +
  geom_point(size=2, shape=1) +
  labs(title = "Number of Hauls per Year") +
  scale_x_continuous(n.breaks = 9)

summarise(acr)

