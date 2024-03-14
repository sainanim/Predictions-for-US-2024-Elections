#### Preamble ####
# Purpose: Poststratification for the model
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 04-model.R


#### Workspace setup ####

library(gutenbergr)
library(haven)
library(knitr)
library(labelled)
library(modelsummary)
library(rstanarm)
library(tidybayes)
library(broom.mixed)
library(here)

poststrat_data <- arrow::read_parquet(file = here("data/analysis_data/poststrat_data.parquet"))
survey_data <- arrow::read_parquet(file = here("data/analysis_data/survey_data.parquet"))
us_election_model <- readRDS(file = here("models/single_bay.rds"))

# By state
proportions_state <- poststrat_data |>
  group_by(state, sex, age, education, income) |>
  summarise(n = n()) |> 
  group_by(state) |>
  mutate(prop = n/sum(n))

proportions_state$estimate <- predict.glm(freq, newdata = proportions_state, type = "response")
proportions_state <- proportions_state |> mutate(num_voters = n*estimate)

errors <- predict.glm(freq, newdata = proportions_state, type = "response", se.fit = T)
upper_state <- errors$fit + errors$se.fit
lower_state <- errors$fit - errors$se.fit
proportion_error_state <- cbind(proportions_state, lower_state, upper_state) |> 
  rename("lower_bound" = ...10, "upper_bound" = ...11)

proportion_error_state <- proportion_error_state |>
  mutate(lower_estimate = n*lower_bound, upper_estimate = n*upper_bound)

vote_for_biden <- proportion_error_state |> mutate(biden_predict_prop = estimate* prop,
                                             biden_predict_prop_lower = lower_bound * prop,
                                             biden_predict_prop_upper = upper_bound * prop) |>
  group_by(state) |>
  summarise(biden_predict = sum(biden_predict_prop),
            biden_lower = sum(biden_predict_prop_lower),
            biden_upper = sum(biden_predict_prop_upper))

state_final_split <- survey_data |>
  group_by(state, vote_biden) |>
  summarise(n = n()) |>
  mutate(prop = n / sum(n))

state_vote_for_biden <- inner_join(state_final_split, vote_for_biden, by = "state") |> filter(vote_biden == '1')

# age
proportions_age <- poststrat_data |>
  group_by(state, sex, age, education, income) |>
  summarise(n = n()) |> 
  group_by(age) |>
  mutate(prop = n/sum(n))

proportions_age$estimate <- predict.glm(freq, newdata = proportions_age, type = "response")
proportions_age <- proportions_age |> mutate(num_voters = n*estimate)

errors <- predict.glm(freq, newdata = proportions_age, type = "response", se.fit = T)
upper_age <- errors$fit + errors$se.fit
lower_age <- errors$fit - errors$se.fit
proportion_error_age <- cbind(proportions_age, lower_age, upper_age) |> 
  rename("lower_bound" = ...10, "upper_bound" = ...11)

proportion_error_age <- proportion_error_age |>
  mutate(lower_estimate = n*lower_bound, upper_estimate = n*upper_bound)

vote_for_biden <- proportion_error_age |> mutate(biden_predict_prop = estimate* prop,
                                             biden_predict_prop_lower = lower_bound * prop,
                                             biden_predict_prop_upper = upper_bound * prop) |>
  group_by(age) |>
  summarise(biden_predict = sum(biden_predict_prop),
            biden_lower = sum(biden_predict_prop_lower),
            biden_upper = sum(biden_predict_prop_upper))

age_final_split <- survey_data |>
  group_by(age, vote_biden) |>
  summarise(n = n()) |>
  mutate(prop = n / sum(n))

age_vote_for_biden <- inner_join(age_final_split, vote_for_biden, by = "age") |> filter(vote_biden == '1')

# sex
proportions_sex <- poststrat_data |>
  group_by(state, sex, age, education, income) |>
  summarise(n = n()) |> 
  group_by(sex) |>
  mutate(prop = n/sum(n))

proportions_sex$estimate <- predict.glm(freq, newdata = proportions_sex, type = "response")
proportions_sex <- proportions_sex |> mutate(num_voters = n*estimate)

errors <- predict.glm(freq, newdata = proportions_sex, type = "response", se.fit = T)
upper_sex <- errors$fit + errors$se.fit
lower_sex <- errors$fit - errors$se.fit
proportion_error_sex <- cbind(proportions_sex, lower_sex, upper_sex) |> 
  rename("lower_bound" = ...10, "upper_bound" = ...11)

proportion_error_sex <- proportion_error_sex |>
  mutate(lower_estimate = n*lower_bound, upper_estimate = n*upper_bound)

vote_for_biden <- proportion_error_sex |> mutate(biden_predict_prop = estimate* prop,
                                             biden_predict_prop_lower = lower_bound * prop,
                                             biden_predict_prop_upper = upper_bound * prop) |>
  group_by(sex) |>
  summarise(biden_predict = sum(biden_predict_prop),
            biden_lower = sum(biden_predict_prop_lower),
            biden_upper = sum(biden_predict_prop_upper))

sex_final_split <- survey_data |>
  group_by(sex, vote_biden) |>
  summarise(n = n()) |>
  mutate(prop = n / sum(n))

sex_vote_for_biden <- inner_join(sex_final_split, vote_for_biden, by = "sex") |> filter(vote_biden == '1')

# general
general_proportion_data <- poststrat_data |>
  group_by(state, sex, age, education, income) |>
  summarise(n = n()) |>
  mutate(prop = n / sum(n))

general_proportion_data$estimate <- predict.glm(freq, newdata = general_proportion_data, type = "response")
general_proportion_data <- general_proportion_data %>%
  mutate(num_voters = n * estimate)

general_errors <- predict.glm(freq, newdata = general_proportion_data, type = "response", se.fit = TRUE)
general_upper_e <- general_errors$fit + general_errors$se.fit
general_lower_e <- general_errors$fit - general_errors$se.fit
general_proportion_error <- cbind(general_proportion_data, lower_e = general_lower_e, upper_e = general_upper_e) %>%
  rename(lower_bound = "lower_e", upper_bound = "upper_e")

general_proportion_error <- general_proportion_error %>%
  mutate(lower_estimate = n * lower_bound, upper_estimate = n * upper_bound)

general_vote_for_biden <- general_proportion_error %>%
  summarise(biden_predict = sum(estimate * prop),
            biden_lower = sum(lower_bound * prop),
            biden_upper = sum(upper_bound * prop))

general_data <- survey_data %>%
  group_by(vote_biden) %>%
  summarise(n = n()) %>%
  mutate(prop = n / sum(n))
