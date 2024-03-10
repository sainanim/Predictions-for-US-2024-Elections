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

#### Test data ####
survey_data <- arrow::read_parquet("data/analysis_data/survey_data.parquet")
poststrat_data <- arrow::read_parquet("data/analysis_data/poststrat_data.parquet")


