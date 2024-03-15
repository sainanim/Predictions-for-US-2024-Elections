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
library(tidyverse)

# read the datasets and model
poststrat_data <- arrow::read_parquet(file = here("data/analysis_data/poststrat_data.parquet"))
survey_data <- arrow::read_parquet(file = here("data/analysis_data/survey_data.parquet"))
us_election_model <- readRDS(file = here("models/single_bay.rds"))

#### Post-stratification 1 (State) ####

# Calculate proportions by state
proportions_state <- poststrat_data %>%
  group_by(state, sex, age, education, income) %>%
  summarise(n = n()) %>%
  group_by(state) %>%
  mutate(prop = n/sum(n))

# Obtain predictions from the Bayesian model
proportions_state$estimate <- predict(us_election_model, newdata = proportions_state, type = "response")
proportions_state <- proportions_state %>% mutate(num_voters = n*estimate)

# Calculate prediction errors and intervals
errors <- predict(us_election_model, newdata = proportions_state, type = "response", se.fit = TRUE)
upper_state <- errors$fit + errors$se.fit
lower_state <- errors$fit - errors$se.fit
proportion_error_state <- cbind(proportions_state, lower_bound = lower_state, upper_bound = upper_state) %>%
  rename(lower_bound = "lower_bound", upper_bound = "upper_bound")

proportion_error_state <- proportion_error_state %>%
  mutate(lower_estimate = n*lower_bound, upper_estimate = n*upper_bound)

# Calculate votes for Biden
vote_for_biden <- proportion_error_state %>%
  mutate(biden_predict_prop = estimate * prop,
         biden_predict_prop_lower = lower_bound * prop,
         biden_predict_prop_upper = upper_bound * prop) %>%
  group_by(state) %>%
  summarise(biden_predict = sum(biden_predict_prop),
            biden_lower = sum(biden_predict_prop_lower),
            biden_upper = sum(biden_predict_prop_upper))

# Final Table
state_final_split <- survey_data %>%
  group_by(state, vote_biden) %>%
  summarise(n = n()) %>%
  mutate(prop = n / sum(n))

state_vote_for_biden <- inner_join(state_final_split, vote_for_biden, by = "state") %>%
  filter(vote_biden == '1')


#### Post-stratification 2 (Age) ####

# Calculate proportions by age
proportions_age <- poststrat_data %>%
  group_by(state, sex, age, education, income) %>%
  summarise(n = n()) %>% 
  group_by(age) %>%
  mutate(prop = n/sum(n))

# Obtain predictions from the Bayesian model
proportions_age$estimate <- predict(us_election_model, newdata = proportions_age, type = "response")
proportions_age <- proportions_age %>% mutate(num_voters = n*estimate)

# Calculate prediction errors and intervals
errors <- predict(us_election_model, newdata = proportions_age, type = "response", se.fit = TRUE)
upper_age <- errors$fit + errors$se.fit
lower_age <- errors$fit - errors$se.fit
proportion_error_age <- cbind(proportions_age, lower_bound = lower_age, upper_bound = upper_age) %>% 
  rename(lower_bound = "lower_bound", upper_bound = "upper_bound")

proportion_error_age <- proportion_error_age %>%
  mutate(lower_estimate = n*lower_bound, upper_estimate = n*upper_bound)

# Calculate votes for Biden
vote_for_biden <- proportion_error_age %>%
  mutate(biden_predict_prop = estimate * prop,
         biden_predict_prop_lower = lower_bound * prop,
         biden_predict_prop_upper = upper_bound * prop) %>%
  group_by(age) %>%
  summarise(biden_predict = sum(biden_predict_prop),
            biden_lower = sum(biden_predict_prop_lower),
            biden_upper = sum(biden_predict_prop_upper))

# Final table
age_final_split <- survey_data %>%
  group_by(age, vote_biden) %>%
  summarise(n = n()) %>%
  mutate(prop = n / sum(n))

age_vote_for_biden <- inner_join(age_final_split, vote_for_biden, by = "age") %>%
  filter(vote_biden == '1')

#### Post-stratification 3 (sex) ####

# Calculate proportions by sex
proportions_sex <- poststrat_data %>%
  group_by(state, sex, age, education, income) %>%
  summarise(n = n()) %>% 
  group_by(sex) %>%
  mutate(prop = n/sum(n))

# Obtain predictions from the Bayesian model
proportions_sex$estimate <- predict(us_election_model, newdata = proportions_sex, type = "response")
proportions_sex <- proportions_sex %>% mutate(num_voters = n*estimate)

# Calculate prediction errors and intervals
errors <- predict(us_election_model, newdata = proportions_sex, type = "response", se.fit = TRUE)
upper_sex <- errors$fit + errors$se.fit
lower_sex <- errors$fit - errors$se.fit
proportion_error_sex <- cbind(proportions_sex, lower_bound = lower_sex, upper_bound = upper_sex) %>% 
  rename(lower_bound = "lower_bound", upper_bound = "upper_bound")

proportion_error_sex <- proportion_error_sex %>%
  mutate(lower_estimate = n*lower_bound, upper_estimate = n*upper_bound)

# Calculate votes for Biden
vote_for_biden <- proportion_error_sex %>%
  mutate(biden_predict_prop = estimate* prop,
         biden_predict_prop_lower = lower_bound * prop,
         biden_predict_prop_upper = upper_bound * prop) %>%
  group_by(sex) %>%
  summarise(biden_predict = sum(biden_predict_prop),
            biden_lower = sum(biden_predict_prop_lower),
            biden_upper = sum(biden_predict_prop_upper))

# Final table
sex_final_split <- survey_data %>%
  group_by(sex, vote_biden) %>%
  summarise(n = n()) %>%
  mutate(prop = n / sum(n))

sex_vote_for_biden <- inner_join(sex_final_split, vote_for_biden, by = "sex") %>%
  filter(vote_biden == '1')

#### Post-stratification 4 (General) ####

general_proportion_data <- poststrat_data |>
  group_by(state, sex, age, education, income) |>
  summarise(n = n()) |>
  mutate(prop = n / sum(n))

# Predictions
general_proportion_data$estimate <- as.vector(predict(us_election_model, newdata = general_proportion_data))

# Prediction Intervals
general_errors <- as.data.frame(predict(us_election_model, newdata = general_proportion_data, se.fit = TRUE))
general_proportion_data$lower_bound <- general_errors$fit - general_errors$se.fit
general_proportion_data$upper_bound <- general_errors$fit + general_errors$se.fit

# Summarize predictions for Biden
general_vote_for_biden <- general_proportion_data %>%
  summarise(biden_predict = sum(estimate * prop),
            biden_lower = sum(lower_bound * prop),
            biden_upper = sum(upper_bound * prop))

# Final Table
general_data <- survey_data %>%
  group_by(vote_biden) %>%
  summarise(n = n()) %>%
  mutate(prop = n / sum(n))

#### Save all tables ####
write.csv(state_vote_for_biden, file = "data/poststratified/state_vote_for_biden.csv", row.names = FALSE)

write.csv(age_vote_for_biden, file = "data/poststratified/age_vote_for_biden.csv", row.names = FALSE)

write.csv(sex_vote_for_biden, file = "data/poststratified/sex_vote_for_biden.csv", row.names = FALSE)

write.csv(general_data, file = "data/poststratified/general_vote_for_biden.csv", row.names = FALSE)

