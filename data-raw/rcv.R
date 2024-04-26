# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(readr, here)

## Variables transformation
rcv <- read_csv(here("data-raw", "rcv.csv"))
library(tidyverse)
rcv <- rcv |>
  mutate(
    Sexo = as_factor(Sexo),
    Estado_civil = as_factor(Estado_civil),
    Escolaridad = as_factor(Escolaridad),
    HAS = as_factor(HAS),
    DM = as_factor(DM),
    Tabaquismo = as_factor(Tabaquismo),
    ColesterolT = as_factor(ColesterolT),
    Trigliceridos = as_factor(Trigliceridos),
    CargaViral = as_factor(CargaViral),
    CD4 = as_factor(CD4),
    RCV = as_factor(RCV)
  )

# write data in correct format to data folder ----
usethis::use_data(rcv, overwrite = TRUE)