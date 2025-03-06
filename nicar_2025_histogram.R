#Before we get started...
#...know your folder path
#...set your working folder to Working Directory

install.packages('tidyverse')
install.packages('ggplot2')

library(tidyverse)
library(ggplot2)

setwd("Users/linkem/Documents/nicar2025-rgraphics")


#Code that manipulates the data
df <- read_csv("import/dataset.csv") %>%
  #Filter out rows that have missing values or no entries
  filter(!is.na(number_of_days)) %>%
  #Bucket our data
  mutate(new_column = ifelse(number_of_days >= 10 & number_of_days <= 14, "highlight", "none"))
view(df)

#Code that visualizes the data
chart <-ggplot(df, aes(x = number_of_days, fill = new_column)) + 
  #Pick our chart type
  geom_histogram(binwidth = 1, color = "white", position = "identity") + 
  #Customize the colors
  scale_fill_manual(values = c("highlight" = "orange4", "none" = "orange")) +  
  #Add a line at the mean point
  geom_vline(aes(xintercept=mean(number_of_days)),
             color="black", linetype="dashed", size=1) +
  #This gets rid of a bunch of stuff you don't need
  theme_minimal()
chart

#Export your file
ggsave(chart, filename=("export/my_export.pdf"), device="pdf", width=700, height=450, units=c("px"), dpi=72)
