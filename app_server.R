library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")
library("tidyverse")

snowcrab_df <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-emilynakaone/main/mfsnowcrab.csv")

server <- function(input, output) {
  
  
  output$boxplot <- renderPlotly ({
    
    snowcrab_year_df <- snowcrab_df %>% 
      group_by(year) %>% 
      filter(year >= input$year_slider_input[1] & year <= input$year_slider_input[2])
    
    boxplot_chart <- ggplot(snowcrab_year_df) + 
      geom_boxplot(mapping = aes(x = factor(year), y = bottom_temperature),
                   color = "blue",
                   fill = "blue",
                   alpha = 0.2,) +
      scale_y_continuous(breaks = seq(-2,8, by = 1)) +
      xlab("Year") +
      ylab("Temperature (C)") +
      ggtitle("Ocean Floor Tempurature Distribution Trends") +
      theme(plot.title = element_text(hjust = 0.5),
            axis.text.x = element_text(angle = -75)) 
    
    return(boxplot_chart)
  })
  
  output$scatterplot <- renderPlotly ({
    
    crabhaul_df <- snowcrab_df %>% 
      select(year, haul) %>% 
      summarise(across(c(haul), sum)) %>% 
      filter(year = input$slider_bar)
    
    scatterplot_chart <- ggplot(crabhaul_df, aes(x = year, y = haul)) +
      geom_point(size=2, shape=1) +
      labs(title = "Number of Hauls per Year", xlab = "Year", ylab = "Number of Hauls") +
      scale_x_continuous(n.breaks = 9)
    
    return(scatterplot_chart)
  })
  
  output$heatmap <- renderPlotly({
    
    snowcrab_df_heatmap <- snowcrab_df %>%
      mutate(cpue = (cpue - min(cpue)) / (max(cpue) - min(cpue)))
    
    
    
    spatial_heat_map_frequency <- 
      ggplot(snowcrab_df_heatmap, aes(x=latitude, y=longitude)) +
      geom_bin2d(bins = 30) +
      xlim(input$latitude) +
      ylim(input$longitude) +
      scale_fill_gradient(low = "light yellow", high = "red") +
      ggtitle("Frequency of Commercial Snow Crab Landings") +
      labs(x = "Latitude (in degrees)", y = "Longitude (in degrees)", 
           subtitle = "Alaskan Eastern Bering Sea, 1975-2018", 
           caption = "Data Source: The Resource Assessment and 
       \n Conservation Engineering Division (RACE) of 
       \n the Alaska Fisheries Science Center (AFSC)") +
      theme(
        plot.title = element_text(hjust = 0.5, color = "black", size = 12, face = "bold"),
        axis.title = element_text(size = 12, color = "#993333", face = "bold"), 
        axis.text = element_text(color = "black"),
        panel.background = element_rect(fill = 'lightblue', color = 'purple')
      )


    ggplotly(spatial_heat_map_frequency) %>% layout(xaxis = list(fixedrange = TRUE), yaxis = list(fixedrange = TRUE)) 
    
  })
}

