library("shiny")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")

snowcrab_df <- read.csv("mfsnowcrab.csv", stringsAsFactors = FALSE)

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
  
}

