library("shiny")
library("plotly")
library("markdown")
library("shinythemes")
library("ggplot2")
library("dplyr")
library("tidyr")
library("plotly")
library("tidyverse")


##INTRO TAB
intro_panel <- tabPanel(
  #title of tab
  "Introduction",
  
  #title of webpage 
  titlePanel(div("Analysis of Snow Crab Population Decline", style = "color:aqua")),
  
  #authors 
  h4("Emily Nakaone, Maya Shukla, Riley Slaton, David Ta"),
  
  #introductory paragraph
  h3("Introduction", style = "color:orange"),
  
  p("Over the past year the population of snow crabs has declined by close to 80%, 
    causing many locations to end crab season prematurely. This sudden decline in 
    snow crabs that reside mainly off the coast in Alaska in the Bering, Beaufort, 
    and Chukchi sea have raised alarms for possible bigger problems. The decline has 
    caused many problems in several populations from fishers to consumers to other marine 
    life, and without intervention it could continue to cause many more issues. 
    Many scientists are confused as to why this is happening and believe that there may 
    be a correlation between climate change and the effect it has on certain ocean species 
    populations. We plan to analyze the correlation between crab populations, sea floor 
    temperatures, fishing haul numbers, and location to better understand the issue and 
    possible solutions to alleviate it."),
  
  #main questions
  h4(strong("Our investigation is driven by these main questions:"), style = "color:orange"),
  h5(em("1. How have ocean temperatures changed over the past 10 years?")),
  h5(em("2. How have declining snow crab populations impacted other species populations?")),
  h5(em("3. Are there any specific regions where overfishing snow crabs has been a pertinent issue?")),
  
  #data set 
  h3("The Data Set", style = "color:orange"),
  
  p("The data set we will be utilizing in this project includes Geospatial Data about Alaskan Snow Crabs 
     in the Eastern Bering Sea. The data was collected between 1975 to 2018  by The Resource Assessment and 
     Conservation Engineering Division (RACE) of the Alaska Fisheries Science Center (AFSC). The data were collected to 
     evaluate the temporal distribution and abundance of the commercially important snow crab. This data collection was 
     funded by the NOAA, National Oceanic and Atmospheric Administration, a government-funded agency, so the data is reputable. 
     NOAA performed bottom trawl surveys to monitor crab stocks."),
  
  #image
  img(src= "https://assets.nautil.us/sites/3/nautilus/Roberts_HERO.png?auto=compress&fm=png&ixlib=php-3.3.1", 
      height= "70%", width = "85%"),
  a(em("image source", href = "https://assets.nautil.us/sites/3/nautilus/Roberts_HERO.png?auto=compress&fm=png&ixlib=php-3.3.1"), 
    style = "color:teal")
)


##CHART 1 TAB
snowcrab_df <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-emilynakaone/main/mfsnowcrab.csv")
slider_year <- range(1975,2018)

boxplot_main_content <- mainPanel(
  plotlyOutput("boxplot"),
  h2("Boxplot to Visualize Variance"),
  p("This visualization can be used to compare the trends of ocean floor tempuratures that were recorded during snowcrab harvests. The use of a box and whisker plot can easily show the difference of the average range of tempuratues, median tempuratures, as well as verious outliers for each year. When looking at the trends of tempuratues in the past decade, you can see a steady increase of average ranges of tempuratures. This can make someone infer that the increase can be due to climate change. As tempuratures van easily vary from year to year, a steady increase of the average tempurature over an entire fishing season each consecutive year can be the result of climate change, which can directly effect populations of snow crabs.")
)

boxplot_sidebar_content <- sidebarPanel(
  sliderInput(
    inputId = "year_slider_input",
    label = "Use Slider to Compare Tempuratures Each Year Ranging From 1975 to 2018",
    min = slider_year[1],
    max = slider_year[2],
    sep = "",
    value = slider_year
  )
)

chart1_tab <- tabPanel(
  "Ocean Floor Temperature Distribution",
  sidebarLayout(
    boxplot_sidebar_content,
    boxplot_main_content
  )
)

##CHART 2 TAB
snowcrab_df <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-emilynakaone/main/mfsnowcrab.csv")

scatterplot_main_content <- mainPanel(
  plotlyOutput("scatterplot"),
  h2("Scatterplot Chart"),
  p("This visualization is used to compare trends in haul number throughout the 
    years. A scatterplot allows for a simple visualization of the various increase
    and decrease in hauls and can be compared to other scatterplots to determine
    similar patterns between the two. When compared to plots depicting ocean
    temperature or CO2 emission we may see a correlation between haul decrease
    and temperature increase indicating a connection between snow crab population 
    declines and climate change.")
)


slider_c2_range <- range(min(snowcrab_df$year), max(snowcrab_df$year))


scatterplot_sidebar_content <- 
  
  fluidRow(

  sidebarPanel(
  sliderInput(inputId = "year_range_input",
    label = "Indicate Year Range to See Trends in Snow Crab Hauls From 1975 to 2018", 
    min = slider_c2_range[1], 
    max = slider_c2_range[2],
    value = c(1980, 2017),
    step = 1,
    ticks = T,
    sep = ""
  )
)
)


chart2_tab <- tabPanel( 
  "Scatterplot Chart",
  sidebarLayout(
    scatterplot_main_content,scatterplot_sidebar_content
  )
)


##CHART 3 COMPONENTS 

#load data from repository 

snowcrab_df <- read_csv("https://raw.githubusercontent.com/info201b-au2022/project-emilynakaone/main/mfsnowcrab.csv")

#Main Plot

plot_main <- mainPanel(tags$b("Alaskan Eastern Bering Sea, 1975-2018"),
  h6(textOutput("caption")),
  align = "left",
  plotlyOutput("heatmap"),
  h2("Heatmap to Visualize Geospatial Hauling Frequency"),
  p("This chart's purpose is to visualize areas of higher frequency Commercial Snow Crab 
  Landings in the Alaskan Eastern Bering Sea region off the coast of Alaska from 1975 - 2018. 
  The chart allows us to gain insight into geospatial aspect of our problem or specific regions of interest 
  with respect to potential overhauling by crabbers. This allows us focus our attention and conduct further analysis 
  on these specific, high-traffic regions of interest to gain more insight towards the proximate/ultimate cause(s) 
  to the diminishing Snow Crab population.")

)

#Sidebar Components

slider_latitude_range <- range(min(snowcrab_df$latitude), max(snowcrab_df$latitude))
slider_longitude_range <- range(min(snowcrab_df$longitude), max(snowcrab_df$longitude))

#Widgets Sidebar 
widgets <- fluidRow(
  
  align = "center",

  sidebarPanel("Use Slider to Adjust Geospatial Scope",
    br(),
    hr(),
    fluidRow(
      
      align = "center",
      sliderInput("longitude", 
                  label = tags$i("longitude"), 
                  min = -178, 
                  max = -159, 
                  value = c(-178, -159), 
                  round = F,
                  step = 0.25, 
                  sep = "", 
                  ticks = T)),
    hr(),
    fluidRow(
      
    align = "center",
    sliderInput("latitude", 
                label = tags$i("latitude"), 
                min = 55, 
                max = 62, 
                value = c(55, 62), 
                round = F,
                step = 0.25,
                sep = "", 
                ticks = T)),
    hr(),
    br(),
        
)
)

##CHART 3 TAB

chart3_tab <- tabPanel(
  "Heatmap of Crab Hauls",
  sidebarLayout(position = "left",
    plot_main,
    widgets
)
)

  





##SUMMARY TAB
summary_panel <- tabPanel(
  #Title of tab 
  "Summary",
  titlePanel(div("Summary", style = "color:aqua")),
  
  h4(strong("The three main takeaways from our study are:"), style = "color:orange"),
  h5("1. Since 2012, ocean floor temperatures have been steadily rising. Increasing by almost 4 degrees C."),
  h5("2. Snow Crab fishing was on a rise from 1975-2012, but began decreasing after 2018. This hints at the 
     decline in snow crab populations."),
  h5("3. Fishermen tend to find and fish for snow crabs in deeper waters, towards the middle of the Alaskan Eastern Bering Sea.
     This shows that snow crab populations are diminishing even in their preferred cold, deep habitat."),
  
  img(src= "https://images.seattletimes.com/wp-content/uploads/2021/09/Bering-Sea-crab-WEB.jpg?d=780x969"),
  
  a(em("image source", href = "https://images.seattletimes.com/wp-content/uploads/2021/09/Bering-Sea-crab-WEB.jpg?d=780x969", 
       height= "40%", width = "55%"),
    style = "color:teal")
)


##REPORT TAB
report_panel <- tabPanel(
  #Title of Tab
  "Report",
  titlePanel(div("Report", style = "color:aqua")),
  
  h3("Conclusion", style = "color:orange"),
  p("Our group started our research with curiosity as to why snow crab populations declined so sharply. By studying the data set, 
    reading news articles, and creating data visualizations, we started to realize that there was a bigger picture at hand.
    The snow crab population decline is a specific result of ocean temperatures and levels rising, ocean acidification., and overfishing. 
    After curating targeted research questions, we were able to draw logical conclusions. First, through the heat map visualization, 
    we are able to learn that there is high snow crab population and hauling towards the middle of the Alaskan Eastern Bering Sea, which
    is where colder and deeper waters are. Next, through the box plot, we are able to see that in the years with higher snow crab populations
    the ocean floor temperatures were relatively low -- around 0 degrees C. However, when populations began to decline the bottom temperatures
    were almost 4 degrees C. This shows us that the snow crabs preferred colder temperatures, and thus were impacted greatly 
    by rising sea temperatures. Through the scatter plot, we are able to understand how fishing may correlate with declining populations.
    Fishermen were hauling an increasing amount of crabs from 1975-2012. However, hauls steeply declined around 2018. This shows that 
    overfishing could also be a factor as to why populations declined. As fishermen began hauling more, peaking between 2010-2012, 
    snow crab populations may not have been able to recover. Lastly, through news articles it is clear that these declining populations
    are a direct byproduct of human influence. Due to rising CO2 emissions, oceans have become more acidic and temperatures have risen.
    This is directly affected the specific habitat that the snow crabs need to thrive."),
  
  h3("Implications", style = "color:orange"),
  p("If we are to accurately determine that the change of climate and ocean temperature has an effect on ocean species populations, 
    this would create further evidence that policy makers need to create more impactful policies on climate change. With a large global 
    population relying on marine life for income and as a food source, it is important to aid in marine conservation, regardless of the 
    reason why species populations are declining. The declining population evidence can also be a sign of overfishing of snow crabs. With 
    the fishing season of crabs being closed this year and possibly next year, it may result in policies changing where the total amount of 
    fishing may reduce for years to come. This would be done through policy changes made by the department of wildlife in order to save species 
    from extinction. Also, with this drastic decline of a species that has never been seen on this scale, technologists and scientists may increase
    the variety of data recorded around marine species to gain an overall better understanding of how ecosystems are affected by external factors 
    such as climate change."),
  
  h3("Limitations", style = "color:orange"),
  p("One limitation of the research questions is the amount of data that can be connected. For example, we want to find the correlation between 
    temperature and population. However, there can be other influences that can affect the overall health of snow crabs, such as oxygen saturation, 
    and acidification of the water that would be harder to record reliably. Another limitation to consider is the possibility of a bias being formed 
    when collecting data. With this type of research question, a declining species population could easily be connected to climate change. This means 
    it is important to analyze data without any bias as it is entirely possible that there could be some other connection to why the population is declining. 
    This is why it is important to look at the context of all the data, and avoid any cherry picked data used to push a certain narrative through data visualization."),
  
  h4("Acknowledgments: We would like to thank Professor Hendry and our TA, Manu Charugundla for guiding us throughout the project!", style = "color:teal"),
  
  h2("Thank you!", style = "color:orange"),
  
  h3("References:"),
  h5("- Bernton, H. (2021, October 9). Alaska Snow crab harvest slashed by nearly 90% after population crash in a warming Bering Sea. The Seattle Times. Retrieved October 31, 2022, 
     from https://www.seattletimes.com/seattle-news/environment/alaska-snow-crab-harvest-slashed-by-nearly-90-after-population-crash-in-a-warming-bering-sea/"),
  h5("- Fisheries, N. O. A. A. (2022, July 19). Alaska Snow crab. NOAA. Retrieved October 31, 2022, from https://www.fisheries.noaa.gov/species/alaska-snow-crab"),
  h5("- Mcguire, C., & Revenga, C. (Eds.). (2021, January 25). A healthy ocean depends on sustainably managed fisheries. The Nature Conservancy. Retrieved October 31, 2022, 
     from https://www.nature.org/en-us/what-we-do/our-priorities/provide-food-and-water-sustainably/food-and-water-stories/global-fisheries/#:~:text=The%20health%20of%20our%20ocean,percent%20of%20the%20world's%20population"),
  h5("- OP, M. (2022, May 23). Snow Crab Geospatial Data (1975-2018). Kaggle. Retrieved October 31, 2022, from https://www.kaggle.com/datasets/4f37ea6085a955d6796199ae9e398396121b90438f2895cd9fa2dd9b8be317f9?resource=download"),
  h5("- Sakashita, M. (2022). OCEAN ACIDIFICATION. Ocean Acidification. Retrieved October 31, 2022, from https://www.biologicaldiversity.org/campaigns/endangered_oceans/index.html")
)


## FINAL FORMAT
ui <- navbarPage(
  tags$b(tags$i("Snow Crab Population Decline")),
  intro_panel,
  chart1_tab,
  chart2_tab,
  chart3_tab,
  summary_panel,
  report_panel,
  theme = shinytheme("superhero")
)