#### Preamble ####
# Purpose: Multilinear logistic regression model
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
survey_data <- arrow::read_parquet("data/analysis_data/survey_data.parquet")


### Model data ####
us_election_model <-
  stan_glmer(
    vote_biden ~ sex + (1|age) + (1|state) + (1|education) + (1|income),
    data = survey_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    cores = 4,
    adapt_delta = 0.99,
    seed = 853
  )

#### Save model ####
saveRDS(
  us_election_model,
  file = "models/us_election_model_mrp.rds"
)

