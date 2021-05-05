# ESOC 214 Spring 2021 Final Project
# Final Project Data Wrangling Script
# Name: Riley Zuckert
# Date: 5/3/21

# LOAD LIBRARIES
library(countrycode)
library(janitor)
library(tidyverse)

# READ DATA IN
nobelprize = read_csv('nobel_prize_awarded_country_details_1901_2019.csv')

# DATA INSPECTION
summary(nobelprize)
ncol(nobelprize)
nrow(nobelprize)

# DATA CLEANING
# standardize column names to snake case
nobelprize_clean = nobelprize %>% 
  clean_names()

# DATA TRANSFORMATION (any mutate, select, and filter)
# add continent to nobelprize_clean
nobelprize_clean = nobelprize_clean %>% 
  mutate(continent = countrycode(sourcevar = country,
                                 origin = "country.name",
                                 destination = "continent"))

# remove rows from nobelprize_clean where continent is NA - only one instance removed - Tibet for 14th Dalai Lama
nobelprize_clean = nobelprize_clean %>% 
  filter(!is.na(continent))

# add country code to nobelprize_clean
nobelprize_clean = nobelprize_clean %>% 
  mutate(country_code = countrycode(nobelprize_clean$country, origin='country.name', destination='iso3c'))

# add decade to nobelprize_clean
nobelprize_clean = nobelprize_clean %>% 
  mutate(decade = paste0(substr(year, 1, 3), '0'))

# WRITE FILE OUT (use write_csv)
write_csv(nobelprize_clean, 'nobelprizelaureates.csv')
