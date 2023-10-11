# saneesh
# 7/10/2023

# Install the required packages----
# install.packages('googlesheets4')
# install.packages('dplyr')
# install.packages('ggplot2')

# Load the required libraries---- 
library(googlesheets4)
library(dplyr)
library(ggplot2)

# copy link to required sheet
intro_data <- read_sheet('https://docs.google.com/spreadsheets/d/1exaaZgECbJPIg8NBI8AbnDJJIkik4LicYuRe7H_g8Qo/edit#gid=0')

# or
# copy the sheet ID
# intro_data1 <- read_sheet('1exaaZgECbJPIg8NBI8AbnDJJIkik4LicYuRe7H_g8Qo')

# give permission when the browser opens
# Or select the gmail ID
# back to RStudio

View(intro_data)

# data cleaning
names(intro_data)

data1 <-
  intro_data %>% select(
    `Have you ever been bitten by a mosquito?`,
    `How did you protect yourself?`,
    `How many times were you bitten?`
  ) %>%
  rename(bitten = `Have you ever been bitten by a mosquito?`,
         measure = `How did you protect yourself?`,
         times = `How many times were you bitten?`) # rename (new name= old name)

names(data1)

print(data1)

# Visualization----

# Number of People Bitten vs. Not Bitten

ggplot(data1, aes(x = bitten, fill= bitten)) +
  geom_bar() +
  labs(title = "Number of People Bitten vs Not Bitten",
       x = "Bitten Status",
       y = "Count")

# Preventive Measures Taken by Those Not Bitten
not_bitten_data <- data1 %>%
  filter(bitten == "No") %>%
  group_by(measure) %>%
  summarise(count = n())

ggplot(not_bitten_data, aes(y = measure, x = count, fill= measure)) +
  geom_bar(stat = "identity") +
  labs(title = "Preventive Measures Taken by Those Not Bitten",
       x = "Count",
       y = "Preventive Measure") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


