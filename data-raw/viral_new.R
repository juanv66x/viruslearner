# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(tidymodels, here, FactoMineR, tidyverse)

## Variables transformation
viral_new <- read_csv(here::here("data-raw", "viral_new.csv"))

# write data in correct format to data folder ----
usethis::use_data(viral_new, overwrite = TRUE)