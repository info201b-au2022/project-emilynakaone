library("shiny")
library("plotly")
library("markdown")

snowcrab_df <- read.csv("mfsnowcrab.csv", stringsAsFactors = FALSE)
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
    value = slider_year
  )
)

chart1_tab <- tabPanel(
  "Boxplot Chart",
  sidebarLayout(
    boxplot_sidebar_content,
    boxplot_main_content
  )
)

ui <- navbarPage(
  "Test",
  chart1_tab
)