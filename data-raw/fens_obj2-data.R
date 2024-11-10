# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(readr, here)

## Variables transformation
fens_obj2 <- readRDS(here("data-raw", "fens_obj2.RDS"))

# write data in correct format to data folder ----
usethis::use_data(fens_obj2, overwrite = TRUE)