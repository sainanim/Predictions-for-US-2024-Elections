#### Preamble ####
# Purpose: Cleans the raw survey and raw poststratification data
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download the raw files as instructed in the data/raw_data/instructions.md and save them in data/raw_data

#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("arrow")
library(tidyverse)
library(arrow)

#### Clean data ####

# read data to clean
survey_data <- read_csv("data/raw_data/31120637.csv")
poststrat_data <- arrow::read_parquet("data/raw_data/usa.parquet")

# Clean and preprocess survey data
survey_data <- survey_data %>% 
  filter(Q1_1 %in% c("Favorable", "Unfavorable")) %>% 
  mutate(age = case_when(
            ppage <= 29 ~ "18-29",
            ppage <= 44 ~ "30-44",
            ppage <= 59 ~ "45-59",
            ppage >= 60 ~ "60+",
            TRUE ~ as.character(ppage)),
         income = ppinc7,
         education = case_when(
           ppeducat == "High school" ~ "High school",
           ppeducat %in% c("Bachelors degree or higher", "Some college") ~ "More than high school",
           ppeducat == "Less than high school" ~ "Less than high school",
           TRUE ~ as.character(ppeducat)),
         state = ppstaten,
         sex = case_when(
           ppgender == "Female" ~ "female",
           ppgender == "Male" ~ "male",
           TRUE ~ as.character(ppgender)),
         vote_biden = case_when(
           Q1_1 == "Favorable" ~ 0,
           Q1_1 == "Unfavorable" ~ 1)) %>%
  select(age, education, income, state, sex, vote_biden) 

# Clean and preprocess poststratification data
poststrat_data <- poststrat_data %>%
  mutate(AGE = as.numeric(AGE)) %>%
  filter(AGE >= 18, STATEICP != 64, STATEICP != 6, FTOTINC >= 0) %>%
  mutate(age = case_when(
    AGE <= 29 ~ "18-29",
    AGE <= 44 ~ "30-44",
    AGE <= 59 ~ "45-59",
    AGE >= 60 ~ "60+",
    TRUE ~ as.character(AGE)),
    education = case_when(
      EDUC == 7 ~ "More than high school",
      EDUC == 6 ~ "High school",
      EDUC == 2 ~ "Less than high school",
      EDUC == 0 ~ "Less than high school",
      EDUC == 4 ~ "Less than high school",
      EDUC == 5 ~ "Less than high school",
      EDUC == 3 ~ "Less than high school",
      EDUC == 10 ~ "More than high school",
      EDUC == 8 ~ "More than high school",
      EDUC == 11 ~ "More than high school",
      EDUC == 1 ~ "Less than high school",
      TRUE ~ as.character(AGE)),
    state = case_when(
      STATEICP == 41 ~ "Alabama",
      STATEICP == 81 ~ "Alaska",
      STATEICP == 61 ~ "Arizona",
      STATEICP == 42 ~ "Arkansas",
      STATEICP == 71 ~ "California",
      STATEICP == 62 ~ "Colorado",
      STATEICP == 1 ~ "Connecticut",
      STATEICP == 11 ~ "Delaware",
      STATEICP == 98 ~ "District of Columbia",
      STATEICP == 43 ~ "Florida",
      STATEICP == 44 ~ "Georgia",
      STATEICP == 82 ~ "Hawaii",
      STATEICP == 63 ~ "Idaho",
      STATEICP == 21 ~ "Illinois",
      STATEICP == 22 ~ "Indiana",
      STATEICP == 31 ~ "Iowa",
      STATEICP == 32 ~ "Kansas",
      STATEICP == 51 ~ "Kentucky",
      STATEICP == 45 ~ "Louisiana",
      STATEICP == 2 ~ "Maine",
      STATEICP == 52 ~ "Maryland",
      STATEICP == 3 ~ "Massachusetts",
      STATEICP == 23 ~ "Michigan",
      STATEICP == 33 ~ "Minnesota",
      STATEICP == 46 ~ "Mississippi",
      STATEICP == 34 ~ "Missouri",
      STATEICP == 35 ~ "Nebraska",
      STATEICP == 65 ~ "Nevada",
      STATEICP == 4 ~ "New Hampshire",
      STATEICP == 12 ~ "New Jersey",
      STATEICP == 66 ~ "New Mexico",
      STATEICP == 13 ~ "New York",
      STATEICP == 47 ~ "North Carolina",
      STATEICP == 36 ~ "North Dakota",
      STATEICP == 24 ~ "Ohio",
      STATEICP == 53 ~ "Oklahoma",
      STATEICP == 72 ~ "Oregon",
      STATEICP == 14 ~ "Pennsylvania",
      STATEICP == 5 ~ "Rhode Island",
      STATEICP == 48 ~ "South Carolina",
      STATEICP == 37 ~ "South Dakota",
      STATEICP == 54 ~ "Tennessee",
      STATEICP == 49 ~ "Texas",
      STATEICP == 67 ~ "Utah",
      STATEICP == 40 ~ "Virginia",
      STATEICP == 73 ~ "Washington",
      STATEICP == 56 ~ "West Virginia",
      STATEICP == 25 ~ "Wisconsin",
      STATEICP == 68 ~ "Wyoming",
      TRUE ~ as.character(STATEICP)),
    sex = case_when(
      SEX == 2 ~ "female",
      SEX == 1 ~ "male",
      TRUE ~ as.character(SEX)),
    income = case_when(
      FTOTINC <= 49999 & FTOTINC >=25000 ~ "$25,000 to $49,999",
      FTOTINC >= 150000 ~ "$150,000 or more",
      FTOTINC >= 50000 & FTOTINC <= 74999 ~ "$50,000 to $74,999",
      FTOTINC >= 10000 & FTOTINC <= 24999 ~ "$10,000 to $24,999",
      FTOTINC >= 100000 & FTOTINC <= 149999 ~ "$100,000 to $149,999",
      FTOTINC >= 75000 & FTOTINC <= 99999 ~ "$75,000 to $99,999",
      FTOTINC < 10000 ~ "Less than $10,000",
      TRUE ~ as.character(FTOTINC))) %>%
  select(age, education, state, income, sex)


#### Save data ####
write_parquet(as.data.frame(survey_data), "data/analysis_data/survey_data.parquet")
write_parquet(as.data.frame(poststrat_data), "data/analysis_data/poststrat_data.parquet")

