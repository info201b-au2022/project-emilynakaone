mfsnowcrab <- read.csv("/Users/20MayaS/info201/project-emilynakaone/data/mfsnowcrab.csv")
library(tidyverse)

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


summary_list <- list()

summary_list$num_observations <- nrow(summary_info)

summary_list$cpue_max_value <- summary_info %>%
  select(average_cpue) %>% 
  filter(average_cpue == max(average_cpue, na.rm = T)) %>% 
  pull(average_cpue)
 
 summary_list$max_bottom_temp <- summary_info %>% 
   select(average_bottom) %>% 
   filter(average_bottom == max(average_bottom)) %>% 
   pull(average_bottom)
 
 summary_list$year_max_cpue <- summary_info %>% 
   select(average_cpue, year) %>% 
   filter(average_cpue == max(average_cpue, na.rm = T)) %>% 
   pull(year)
 
 summary_list$bottom_temp_max_cpue <- summary_info %>% 
   select(average_cpue,average_bottom) %>% 
   filter(average_cpue == max(average_cpue, na.rm = T)) %>%
   pull(average_bottom)
 
 summary_list$year_max_bottom_temp <- summary_info %>% 
   select(average_bottom, year) %>% 
   filter(average_bottom == max(average_bottom, na.rm = T)) %>% 
   pull(year)
 
 summary_list$cpue_min_value <- summary_info %>% 
   select(average_cpue) %>% 
   filter(average_cpue == min(average_cpue, na.rm = T)) %>% 
   pull(average_cpue)
 
 summary_list$min_bottom_temp <- summary_info %>% 
   select(average_bottom) %>% 
   filter(average_bottom == min(average_bottom)) %>% 
   pull(average_bottom)
 
 summary_list$year_min_cpue <- summary_info %>% 
   select(average_cpue, year) %>% 
   filter(average_cpue == min(average_cpue, na.rm = T)) %>% 
   pull(year)
 
 summary_list$bottom_temp_min_cpue <- summary_info %>% 
   select(average_cpue,average_bottom) %>% 
   filter(average_cpue == min(average_cpue, na.rm = T)) %>%
   pull(average_bottom)
 
 summary_list$year_min_bottom_temp <- summary_info %>% 
   select(average_bottom, year) %>% 
   filter(average_bottom == min(average_bottom, na.rm = T)) %>% 
   pull(year)
  