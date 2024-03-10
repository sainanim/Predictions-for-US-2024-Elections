#### Preamble ####
# Purpose: Poststratification for the model
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 04-model.R


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Read data and model####
poststrat_data <- arrow::read_parquet("data/analysis_data/poststrat_data.parquet")
us_election_model <- readRDS(file = "us_election_model_mrp.rds")

#### Poststratification ####
poststrat_data_cells <-
  poststrat_data |>
  count(age, education, state, income, sex)

poststrat_data_cells <-
  poststrat_data_cells |>
  mutate(prop = n / sum(n),
         .by = state)

poststrat_data_cells

biden_support_by_state <-
  us_election_model |>
  add_epred_draws(newdata = poststrat_data_cells) |>
  rename(support_biden_predict = .epred) |>
  mutate(support_biden_predict_prop = support_biden_predict * prop) |>
  ungroup() |> 
  summarise(support_biden_predict = sum(support_biden_predict_prop),
            .by = c(stateicp, .draw)) |>
  summarise(
    mean = mean(support_biden_predict),
    lower = quantile(support_biden_predict, 0.025),
    upper = quantile(support_biden_predict, 0.975),
    .by = stateicp
  )

head(biden_support_by_state)

#### Poststratify ####
biden_support_by_state <-
  us_election_model |>
  add_epred_draws(newdata = poststrat_data_cells) |>
  rename(support_biden_predict = .epred) |>
  mutate(support_biden_predict_prop = support_biden_predict * prop) |>
  ungroup() |> 
  summarise(support_biden_predict = sum(support_biden_predict_prop),
            .by = c(stateicp, .draw)) |>
  summarise(
    mean = mean(support_biden_predict),
    lower = quantile(support_biden_predict, 0.025),
    upper = quantile(support_biden_predict, 0.975),
    .by = stateicp
  )

head(biden_support_by_state)
