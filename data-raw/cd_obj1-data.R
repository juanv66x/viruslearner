# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(readr, here)

## Variables transformation
cd_obj1 <- readRDS(here("data-raw", "cd_obj1.RDS"))

# write data in correct format to data folder ----
usethis::use_data(cd_obj1, overwrite = TRUE)