# Title: Ideological differences between young men and women, part 02
# Author: Bruno Alves de Carvalho
# Status: ongoing
# Purpose of research: The purpose of my research is to explore the ideological differences between young men and women across the globe. In particular, I would like to test if differences exist with regards to traditional values associated with God, the family and nation. And if these differences persist when accounting for educational level. This is purely for my own interest and desire to have an informed opinion on such matters. 

# Set the directory to the data warehouse
setwd("/Users/brunoalvesdecarvalho/Desktop/DataWarehouse_20231015_ve01")

# Load packages
library(tidyverse)
library(memoise)
library(haven)

# Load functions
source("R_Scripts/FunctionRepository_20231016_ve01.R")

# Load data
aggregated_data_shp <- 
  readRDS("SHP/Data_Aggregated_1999_2022/cached_data_shp.rds")

aggregated_data_ess <- 
  aggregate_data_ess()

aggregated_data_wvs <- 
  read_dta("WVS/WVS_TimeSeries_4_0.dta", encoding = "UTF-8")

# Selecting variables necessary for analysis
selected_vars_shp <- 
  rep(
    list(
      c(
        # id and control variables
        "idpers",
        "idhous$$",
        "year",
        "age$$",
        "generation",
        "sex$$",
        "iptotni", # total income
        "iwyni", # working income
        "canton$$",
        "com2_$$",
        
        # ideological gap between young men and women
        ## 1.Perception of unfairness
        "p$$p20", # gender: women in general penalized, scale 0 to 10 (strongly agree)
        "p$$p21", # gender: personally penalized
        "p$$p22", # gender: in favor of measures
        ## 2.Evaluating unfairness
        "p$$f08", # time for housework, hours weekly
        "p$$f63", # time for care work, hours weekly
        "p$$w77", # number of hours worked per week
        "p$$w80c", # current main job: expectations to work during non-work hours
        ## 3.Assessing differences
        "p$$d80", # total number of children wanted
        "p$$d81", # child wanted in the next 24 months
        "p$$d92", # opinion on family: child suffers with working mother
        "p$$p85", # identity: Switzerland, scale 0 to 10 (very important)
        "p$$r21", # feeling of religiosity
        "p$$r16", # belief in God or something divine, scale 1 to 5
        
        # political factors
        "p$$p10", # political position, scale 1 (left) to 10 (right)
        "p$$p10", # party of choice if elections tomorrow
        "p$$p46", # political position of father
        "p$$p47", # political position of mother
        
        # socio-demographic factors
        "educat$$", # highest level of education achieved, 11 grid
        "edugr$$", # highest level of education achieved, 19 grid
        "edyear$$", # number of years in education
        "p$$e15", # current education, 19 grid
        "noga2m$$" # nomenclature of economic activities
      )
    ), 
    length(1999:2022)
  )

select_vars_ess <-
  c(
    # socio-demographics
    "edlvdch",
    "eisced",
    "gndr",
    "agea",
    "yrbnr",
    "cntry",
    "year",
    
    # ideological gap between young men and women
    "rlgblg", # belonging to particular religion or denomination, binary yes/no
    "rlgdgr", # how religious are you, scale of 0 to 10 (very religious)
    "atchctr", # how emotionally attached to country, scale of 0 to 10 (very emotionally attached)
    
    # political factors
    "lrscale" # placement on left right scale (scale 0 to 10, right)
     )

select_vars_wvs <-
  c(
    # socio-demographics: age, gender, education, country
    "COUNTRY_ALPHA",
    "X001", # sex, male = 1, female = 2
    "X003", # age
    "X002", # year of birth
    "X025R", # education level (re-coded: lower, middle, upper)
    "X025A_01", # education level, ISCED, only available for 2017

    # ideological gap between young men and women
    "A001", # important in life: family
    "D061", # pre-school child suffers with working mother, scale 1 to 4 (strongly disagree)
    "A006", # important in life: religion
    "F050", # believe in God, binary yes / no
    "F063", # how important is god in your life, scale 1 to 10 (very important)
    "Y011B", # nationalism: national pride, scale 0 to 1 (very high)
    
    # political factors
    "E033" # self positioning in political scale, 1 to 10 (right)
  )

# Merge data
merged_data_shp <-
  shp_merge_data(aggregated_data_shp, selected_vars_shp)

merged_data_ess <- 
  merge_data_ess(aggregated_data_ess)

merged_data_wvs <-
  aggregated_data_wvs %>% 
  select(any_of(select_vars_wvs))

# Cache data
saveRDS(merged_data_shp, "Cached_Data/cached_gender_divide_shp.rds")
saveRDS(merged_data_ess, "Cached_Data/cached_gender_divide_ess.rds")
saveRDS(merged_data_wvs, "Cached_Data/cached_gender_divide_wvs.rds")




