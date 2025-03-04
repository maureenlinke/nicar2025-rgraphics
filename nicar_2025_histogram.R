#Before we get started...
#...know your folder path
#...set your working folder to Working Directory

install.packages('tidyverse')
install.packages('ggplot2')
install.packages('here')

library(tidyverse)
library(ggplot2)
library(here)

df <- read_csv("/Users/stamms/Documents/r_projects/nicar_2025/import/dataset.csv") %>%
  #Filter out rows that have missing values or no entries
  filter(!is.na(los_days_at_current_facility)) %>%
  #Bucket our data
  mutate(new_column = ifelse(los_days_at_current_facility >= 10 & los_days_at_current_facility <= 14, "highlight", "none"))
view(df)

#Start of code that visualizes the data
chart <-ggplot(df, aes(x = los_days_at_current_facility, fill = new_column)) + 
  #Pick our chart type
  geom_histogram(binwidth = 1, color = "white", position = "identity") + 
  #Customize the colors
  scale_fill_manual(values = c("highlight" = "orange4", "none" = "orange")) +  
  #This gets rid of a bunch of stuff you don't need
  theme_minimal() +
  #Add a line at the mean point
  geom_vline(aes(xintercept=mean(los_days_at_current_facility)),
             color="black", linetype="dashed", size=1)
chart

#Export your file
ggsave(chart, filename=here("Documents/r_projects/nicar_2025/export/my_export.pdf"), device="pdf", width=700, height=450, units=c("px"), dpi=72)
