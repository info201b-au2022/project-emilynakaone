
library(tidyverse)
mfsnowcrab <- read.csv("~/Documents/INFO201/project-emilynakaone/data/mfsnowcrab.csv")
#calculate average surface and bottom temperatures
avg_temps_per_year <- mfsnowcrab %>% 
  select(surface_temperature, bottom_temperature, year) %>% 
  drop_na() %>%
  group_by(year) %>% 
  mutate(average_bottom = mean(bottom_temperature)) %>% 
  mutate(average_surface = mean(surface_temperature)) %>% 
  distinct(year, average_surface, average_bottom)
avg_temps_per_year$average_bottom <- round(avg_temps_per_year$average_bottom, digit=2)
avg_temps_per_year$average_surface <- round(avg_temps_per_year$average_surface, digit=2)

#calculate difference between bottom and surface temperatures
avg_temps_per_year$temperature_difference <- 
  c(avg_temps_per_year$average_surface - avg_temps_per_year$average_bottom)

#calculate average bottom depth per year
avg_depth_per_year <- mfsnowcrab %>% 
  select(bottom_depth, year) %>% 
  drop_na() %>%
  group_by(year) %>% 
  mutate(average_depth = mean(bottom_depth)) %>% 
  distinct(year, average_depth)
avg_depth_per_year$average_depth <- round(avg_depth_per_year$average_depth, digit=2)

#calculate average cpue per year
avg_cpue_per_year <- mfsnowcrab %>% 
  select(cpue, year) %>% 
  drop_na() %>%
  group_by(year) %>% 
  mutate(average_cpue = mean(cpue)) %>% 
  distinct(year, average_cpue)
avg_cpue_per_year$average_cpue <- round(avg_cpue_per_year$average_cpue, digit=2)

#merge average data frames by year
depth_cpue <- merge(avg_depth_per_year, avg_cpue_per_year, by="year")
summary_info <- merge(depth_cpue, avg_temps_per_year, by="year")
summary_info <- round(summary_info)

 
  