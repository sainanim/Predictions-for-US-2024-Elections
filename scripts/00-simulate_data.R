#### Preamble ####
# Purpose: Simulated the survey and poststratification datasets
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("dplyr")
library(tidyverse)
library(dplyr)

#### Simulate survey dataset ####
set.seed(323)
n <- 1000

age <- sample(18:98, n, replace = TRUE) # Simulate age data (ranging from 18 to 98)
sex <- sample(c("Female", "Male"), n, replace = TRUE) # Simulate sex data (female or male)
income <- round(runif(n, min = 20000, max = 1000000)) # Simulate family income data (ranging from 20000 to 1000000)
 
state_labels <- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island",
"Vermont", "Delaware", "New Jersey", "New York", "Pennsylvania", "Illinois", "Indiana", "Michigan", "Ohio",
"Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota", "Virginia",
"Alabama", "Arkansas", "Florida", "Georgia", "Louisiana", "Mississippi", "North Carolina", "South Carolina",
"Texas", "Kentucky", "Maryland", "Oklahoma", "Tennessee", "West Virginia", "Arizona", "Colorado", "Idaho", "Montana",
"Nevada", "New Mexico", "Utah", "Wyoming", "California", "Oregon", "Washington", "Alaska", "Hawaii", "Puerto Rico",
"State groupings (1980 Urban/rural sample)", "Overseas Military Installations", "District of Columbia",
"State not identified")
state <- sample(state_labels, n, replace = TRUE) # Simulate state data

vote_biden <- sample(0:1, n, replace = TRUE) # Simulate vote data (0 for Trump, 1 for Biden)

survey_data <- data.frame(age, sex, income, state, vote_biden)
head(survey_data)

#### Simulate poststratification dataset ####
set.seed(323)
n <- 10000

age <- sample(18:98, n, replace = TRUE) # Simulate age data (ranging from 18 to 98)
sex <- sample(c("Female", "Male"), n, replace = TRUE) # Simulate sex data (female or male)
income <- round(runif(n, min = 20000, max = 1000000)) # Simulate family income data (ranging from 20000 to 1000000)

state_labels <- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island",
                  "Vermont", "Delaware", "New Jersey", "New York", "Pennsylvania", "Illinois", "Indiana", "Michigan", "Ohio",
                  "Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota", "Virginia",
                  "Alabama", "Arkansas", "Florida", "Georgia", "Louisiana", "Mississippi", "North Carolina", "South Carolina",
                  "Texas", "Kentucky", "Maryland", "Oklahoma", "Tennessee", "West Virginia", "Arizona", "Colorado", "Idaho", "Montana",
                  "Nevada", "New Mexico", "Utah", "Wyoming", "California", "Oregon", "Washington", "Alaska", "Hawaii", "Puerto Rico",
                  "State groupings (1980 Urban/rural sample)", "Overseas Military Installations", "District of Columbia",
                  "State not identified")
state <- sample(state_labels, n, replace = TRUE) # Simulate state data


poststratification_data <- data.frame(age, sex, income, state)
head(poststratification_data)







