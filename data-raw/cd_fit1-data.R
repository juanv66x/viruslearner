# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(readr, here)

## Variables transformation
cd_fit1 <- readRDS(here("data-raw", "cd_fit1.RDS"))

# write data in correct format to data folder ----
usethis::use_data(cd_fit1, overwrite = TRUE)