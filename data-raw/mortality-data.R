# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(tidymodels, here, tidyverse)

## Variables transformation
mortality <- read_csv(here::here("data-raw", "mortality.csv")) |>
  mutate_at(vars(c(V4:V18),20,22:23,25), as_factor)

# write data in correct format to data folder ----
usethis::use_data(mortality, overwrite = TRUE)