# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(readr, here)

## Variables transformation
fens_fit1 <- readRDS(here("data-raw", "fens_fit1.RDS"))

# write data in correct format to data folder ----
usethis::use_data(fens_fit1, overwrite = TRUE)