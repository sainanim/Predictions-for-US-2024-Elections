#### Preamble ####
# Purpose: Tests survey and postratification data
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Load data ####
survey_data <- arrow::read_parquet("data/analysis_data/survey_data.parquet")
poststrat_data <- arrow::read_parquet("data/analysis_data/poststrat_data.parquet")


#### Test survey data ####

print("Testing survey data")

# Test 1: Check for missing data
if (any(is.na(survey_data))) {
  print("There are missing data.")
} else {
  print("There are no missing data.")
}

# Test 2: Check the number of columns
if (ncol(survey_data) == 6) {
  print("Number of columns is 6.")
} else {
  print("Number of columns is not 6.")
}

# Test 3: Check the values in the "vote_biden" column
if (all(survey_data$vote_biden %in% c(1, 0))) {
  print("Values in the 'vote_biden' column are valid.")
} else {
  print("There are invalid values in the 'vote_biden' column.")
}

# Test 4: Check the values in the "age" column
valid_age <- c("18-29", "30-44", "45-59", "60+")
if (all(survey_data$age %in% valid_age)) {
  print("Values in the 'age' column are valid.")
} else {
  print("There are invalid values in the 'age' column.")
}

# Test 5: Check the values in the "education" column
valid_education <- c("High school", "More than high school", "Less than high school")
if (all(survey_data$education %in% valid_education)) {
  print("Values in the 'education' column are valid.")
} else {
  print("There are invalid values in the 'education' column.")
}

# Test 6: Check the values in the "state" column
valid_state <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California",
                     "Colorado", "Connecticut", "Delaware", "District of Columbia",
                     "Florida", "Georgia", "Hawaii", "Idaho", "Illinois",
                     "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
                     "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
                     "Mississippi", "Missouri", "Nebraska", "Nevada", "New Hampshire",
                     "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
                     "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
                     "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
                     "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming")
if (all(survey_data$state %in% valid_state)) {
  print("Values in the 'state' column are valid.")
} else {
  print("There are invalid values in the 'state' column.")
}

# Test 7: Check the values in the "state" column
if (all(survey_data$sex %in% c("female", "male"))) {
  print("Values in the 'sex' column are valid.")
} else {
  print("There are invalid values in the 'sex' column.")
}

# Test 8: Check the values in the "income" column
valid_income <- c("$25,000 to $49,999",
                  "$150,000 or more",
                  "$50,000 to $74,999",
                  "$10,000 to $24,999",
                  "$100,000 to $149,999",
                  "$75,000 to $99,999",
                  "Less than $10,000")

if (all(survey_data$income %in% valid_income)) {
  print("Values in the 'income' column are valid.")
} else {
  print("There are invalid values in the 'income' column.")
}

#### Test survey data ####

print("Testing survey data")

# Test 1: Check for missing data
if (any(is.na(survey_data))) {
  print("There are missing data.")
} else {
  print("There are no missing data.")
}

# Test 2: Check the number of columns
if (ncol(survey_data) == 6) {
  print("Number of columns is 6.")
} else {
  print("Number of columns is not 6.")
}

# Test 3: Check the values in the "vote_biden" column
if (all(survey_data$vote_biden %in% c(1, 0))) {
  print("Values in the 'vote_biden' column are valid.")
} else {
  print("There are invalid values in the 'vote_biden' column.")
}

# Test 4: Check the values in the "age" column
valid_age <- c("18-29", "30-44", "45-59", "60+")
if (all(survey_data$age %in% valid_age)) {
  print("Values in the 'age' column are valid.")
} else {
  print("There are invalid values in the 'age' column.")
}

# Test 5: Check the values in the "education" column
valid_education <- c("High school", "More than high school", "Less than high school")
if (all(survey_data$education %in% valid_education)) {
  print("Values in the 'education' column are valid.")
} else {
  print("There are invalid values in the 'education' column.")
}

# Test 6: Check the values in the "state" column
valid_state <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California",
                 "Colorado", "Connecticut", "Delaware", "District of Columbia",
                 "Florida", "Georgia", "Hawaii", "Idaho", "Illinois",
                 "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
                 "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
                 "Mississippi", "Missouri", "Nebraska", "Nevada", "New Hampshire",
                 "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
                 "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
                 "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
                 "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming")
if (all(survey_data$state %in% valid_state)) {
  print("Values in the 'state' column are valid.")
} else {
  print("There are invalid values in the 'state' column.")
}

# Test 7: Check the values in the "state" column
if (all(survey_data$sex %in% c("female", "male"))) {
  print("Values in the 'sex' column are valid.")
} else {
  print("There are invalid values in the 'sex' column.")
}

# Test 8: Check the values in the "income" column
valid_income <- c("$25,000 to $49,999",
                  "$150,000 or more",
                  "$50,000 to $74,999",
                  "$10,000 to $24,999",
                  "$100,000 to $149,999",
                  "$75,000 to $99,999",
                  "Less than $10,000")

if (all(survey_data$income %in% valid_income)) {
  print("Values in the 'income' column are valid.")
} else {
  print("There are invalid values in the 'income' column.")
}

#### Test poststratification data ####

print("Testing poststratification data")

# Test 1: Check for missing data
if (any(is.na(poststrat_data))) {
  print("There are missing data.")
} else {
  print("There are no missing data.")
}

# Test 2: Check the number of columns
if (ncol(poststrat_data) == 5) {
  print("Number of columns is 5.")
} else {
  print("Number of columns is not 5.")
}

# Test 3: Check the values in the "age" column
valid_age <- c("18-29", "30-44", "45-59", "60+")
if (all(poststrat_data$age %in% valid_age)) {
  print("Values in the 'age' column are valid.")
} else {
  print("There are invalid values in the 'age' column.")
}

# Test 4: Check the values in the "education" column
valid_education <- c("High school", "More than high school", "Less than high school")
if (all(poststrat_data$education %in% valid_education)) {
  print("Values in the 'education' column are valid.")
} else {
  print("There are invalid values in the 'education' column.")
}

# Test 5: Check the values in the "state" column
valid_state <- c("Alabama", "Alaska", "Arizona", "Arkansas", "California",
                 "Colorado", "Connecticut", "Delaware", "District of Columbia",
                 "Florida", "Georgia", "Hawaii", "Idaho", "Illinois",
                 "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana",
                 "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota",
                 "Mississippi", "Missouri", "Nebraska", "Nevada", "New Hampshire",
                 "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota",
                 "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
                 "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
                 "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming")
if (all(poststrat_data$state %in% valid_state)) {
  print("Values in the 'state' column are valid.")
} else {
  print("There are invalid values in the 'state' column.")
}

# Test 6: Check the values in the "state" column
if (all(poststrat_data$sex %in% c("female", "male"))) {
  print("Values in the 'sex' column are valid.")
} else {
  print("There are invalid values in the 'sex' column.")
}

# Test 7: Check the values in the "income" column
valid_income <- c("$25,000 to $49,999",
                  "$150,000 or more",
                  "$50,000 to $74,999",
                  "$10,000 to $24,999",
                  "$100,000 to $149,999",
                  "$75,000 to $99,999",
                  "Less than $10,000")

if (all(poststrat_data$income %in% valid_income)) {
  print("Values in the 'income' column are valid.")
} else {
  print("There are invalid values in the 'income' column.")
}

#### Test for exactly same values ####

# Test 1 : state
unique_poststrat <- setdiff(unique(poststrat_data$state), unique(survey_data$state))
unique_survey <- setdiff(unique(survey_data$state), unique(poststrat_data$state))

if (all(unique_poststrat %in% unique_survey) && all(unique_survey %in% unique_poststrat)) {
  print("The 'state' columns have the same unique values.")
} else {
  print("The 'state' columns have different unique values.")
}

# Test 2 : income
unique_poststrat <- setdiff(unique(poststrat_data$income), unique(survey_data$income))
unique_survey <- setdiff(unique(survey_data$income), unique(poststrat_data$income))

if (all(unique_poststrat %in% unique_survey) && all(unique_survey %in% unique_poststrat)) {
  print("The 'income' columns have the same unique values.")
} else {
  print("The 'income' columns have different unique values.")
}

# Test 3 : sex
unique_poststrat <- setdiff(unique(poststrat_data$sex), unique(survey_data$sex))
unique_survey <- setdiff(unique(survey_data$sex), unique(poststrat_data$sex))

if (all(unique_poststrat %in% unique_survey) && all(unique_survey %in% unique_poststrat)) {
  print("The 'sex' columns have the same unique values.")
} else {
  print("The 'sex' columns have different unique values.")
}

# Test 4 : age
unique_poststrat <- setdiff(unique(poststrat_data$age), unique(survey_data$age))
unique_survey <- setdiff(unique(survey_data$age), unique(poststrat_data$age))

if (all(unique_poststrat %in% unique_survey) && all(unique_survey %in% unique_poststrat)) {
  print("The 'age' columns have the same unique values.")
} else {
  print("The 'age' columns have different unique values.")
}

# Test 5 : education
unique_poststrat <- setdiff(unique(poststrat_data$education), unique(survey_data$education))
unique_survey <- setdiff(unique(survey_data$education), unique(poststrat_data$education))

if (all(unique_poststrat %in% unique_survey) && all(unique_survey %in% unique_poststrat)) {
  print("The 'education' columns have the same unique values.")
} else {
  print("The 'education' columns have different unique values.")
}
