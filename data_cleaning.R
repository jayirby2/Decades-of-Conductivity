library(tidyverse)

# Reading Upper Manatee River data

umr_data <- read_csv("Data.csv") %>%
  mutate(Date = as.Date(Date, format="%m/%d/%Y"), 
         Year = as.numeric(format(Date, "%Y"))) %>%
  # Remove rows with clear outliers and years before 1980 for modeling purposes
  filter(pH <= 9 & Year >= 1979) %>%
  na.omit()

umr_data <- umr_data %>%
  mutate(Source = ifelse(Year < 1986, "Archive", "Current"))
# Reading Site Comparisons Data

sc_data <- read_csv("Site Comparisons.csv") %>%
  mutate(Date = as.Date(Date, format = "%m/%d/%Y"), 
         Year = as.numeric(format(Date, "%Y"))) %>%
  na.omit()
