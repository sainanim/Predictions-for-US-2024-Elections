#### Preamble ####
# Purpose: Multilinear logistic regression model
# Author: Kaavya Kalani, Monica Sainani
# Date: 9 March 2024
# Contact: kaavya.kalani@mail.utoronto.ca, monica.sainani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 01-data_cleaning.R


#### Workspace setup ####
# install.packages("tidyverse")
# install.packages("arrow")
# install.packages("rstanarm")
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
survey_data <- arrow::read_parquet("data/analysis_data/survey_data.parquet")


### Model data ####
# this is a single level bayesian logistic regression model
single_bay <-
  stan_glm(
    vote_biden ~ sex + age + state + education + income,
    data = survey_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    cores = 4,
    adapt_delta = 0.99,
    seed = 853
  )

summary(single_bay)

# multi_bay <-
#   stan_glmer(
#     vote_biden ~ sex + (1|age) + (1|state) + (1|education) + (1|income),
#     data = survey_data,
#     family = binomial(link = "logit"),
#     prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
#     cores = 4,
#     adapt_delta = 0.99,
#     seed = 853
#   )
# 
# summary(multi_bay)
# 
# freq <-  
#   glm(vote_biden ~ as.factor(sex) + as.factor(age) + as.factor(state) + as.factor(education) + as.factor(income),
#                data = survey_data,
#                family = "binomial")
#   
# summary(freq)

#### Save model ####
saveRDS(
  single_bay,
  file = "models/single_bay.rds"
)

# saveRDS(
#   multi_bay,
#   file = "models/multi_bay.rds"
# )

# saveRDS(
#   freq,
#   file = "models/freq.rds"
# )

