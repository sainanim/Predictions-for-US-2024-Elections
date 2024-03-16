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

# Simulate state data (states in the US)
states <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware",
"Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine",
"Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada",
"New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
"Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia",
"Washington", "West Virginia", "Wisconsin", "Wyoming")
state <- sample(states, n, replace = TRUE)

# Simulate general vote data (0 for Trump, 1 for Biden)
general_vote <- sample(0:1, n, replace = TRUE)

# Create a dataframe
simulated_data <- data.frame(person, age, sex, income, state, general_vote)

# View the first few rows of the simulated dataset
head(simulated_data)






