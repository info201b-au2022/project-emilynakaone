library(dplyr)
library(tidyr)
library(ggplot2)

snowcrab_df <- read.csv("mfsnowcrab.csv")

temps_17_18 <- snowcrab_df  %>% 
  filter(year >= 2012)

boxplot_chart <- ggplot(temps_17_18) + 
  geom_boxplot(mapping = aes(x = factor(year), y = bottom_temperature),
               color = "blue",
               fill = "blue",
               alpha = 0.2,
               ) +
  scale_y_continuous(breaks = seq(-2,8, by = 1)) +
  xlab("Year (2012-2018)") +
  ylab("Temperature (°C)") +
  ggtitle("Ocean Floor Tempurature Distribution Trends") +
  theme(plot.title = element_text(hjust = 0.5))

       