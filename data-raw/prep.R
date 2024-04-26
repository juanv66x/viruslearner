# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(tidyverse, here)

## Variables transformation
prep <- read_csv(here("data-raw", "prep.csv"))
prep <- prep |>
  mutate(across(where(is.numeric), as_factor))
names(prep) <- c("gender", "age", "education", "maritalstatus", "institution", 
                 "orientation", "knowHIV", "knowHIVTx", "HIVtest", "otherSTItest", 
                 "STIhistory", "satisfaction", "condomuse", "partners", "nopreservpartners", 
                 "stablepartner", "alcohol", "druguse", "lastHIVtest", "knowPrEP", 
                 "understandPrEP", "dailyPrEP", "intermittentPrEP", "PrEPinfoLocation", 
                 "PrEPUse", "PrEPorPEPprescription", "knowPrEPorPEP", "sourcePrEPorPEP", 
                 "knowPEP", "heardPEP", "usedPEP", "PEPUse", "intervention", "knowledge")

# write data in correct format to data folder ----
usethis::use_data(prep, overwrite = TRUE)