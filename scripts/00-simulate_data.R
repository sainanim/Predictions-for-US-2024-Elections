#### Preamble ####
# Purpose: Simulates... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 11 February 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]


#### Workspace setup ####
library(tidyverse)
library(dplyr)


#### Simulate data ####
# Set seed for reproducibility
set.seed(123)

# Define the number of observations
n <- 1000

# Simulate person column (serial number)
person <- 1:n

# Simulate age data (ranging from 18 to 98)
age <- sample(18:98, n, replace = TRUE)

# Simulate sex data (female or male)
sex <- sample(c("Female", "Male"), n, replace = TRUE)

# Simulate family income data (ranging from 20000 to 1000000)
income <- runif(n, min = 20000, max = 1000000)

# Simulate state data using the provided codes and labels
state_codes <- c("09", "23", "25", "33", "44", "50", "10", "34", "36", "42", "01", "18", "26", "36", "55",
"29", "20", "22", "31", "46", "47", "27", "32", "37", "38", "51", "19", "40", "28", "30", "35", "45", "60",
"10", "11", "12", "13", "24", "41", "48", "56", "21", "54", "50", "55", "23", "24", "44", "48", "49", "15",
"16", "17", "05", "06", "08", "78", "97", "98", "99")
state_labels <- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island",
"Vermont", "Delaware", "New Jersey", "New York", "Pennsylvania", "Illinois", "Indiana", "Michigan", "Ohio",
"Wisconsin", "Iowa", "Kansas", "Minnesota", "Missouri", "Nebraska", "North Dakota", "South Dakota", "Virginia",
"Alabama", "Arkansas", "Florida", "Georgia", "Louisiana", "Mississippi", "North Carolina", "South Carolina",
"Texas", "Kentucky", "Maryland", "Oklahoma", "Tennessee", "West Virginia", "Arizona", "Colorado", "Idaho", "Montana",
"Nevada", "New Mexico", "Utah", "Wyoming", "California", "Oregon", "Washington", "Alaska", "Hawaii", "Puerto Rico",
"State groupings (1980 Urban/rural sample)", "Overseas Military Installations", "District of Columbia",
"State not identified")
state <- sample(state_labels, n, replace = TRUE)

# Simulate general vote data (0 for Trump, 1 for Biden)
general_vote <- sample(0:1, n, replace = TRUE)

# Create a dataframe
simulated_data <- data.frame(person, age, sex, income, state, general_vote)

# View the first few rows of the simulated dataset
head(simulated_data)






