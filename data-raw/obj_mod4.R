# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(readr, here)

## Variables transformation
obj_mod4 <- readRDS(here("data-raw", "obj_mod4.RDS"))

# write data in correct format to data folder ----
usethis::use_data(obj_mod4, overwrite = TRUE)