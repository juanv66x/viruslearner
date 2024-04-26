# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(tidyverse, here)

## Variables transformation
abs <- read_csv(here("data-raw", "abs.csv"))
library(tidyverse)
abs <- abs |>
  dplyr::transmute(edad = as_factor(Edad),
                   sexo = as_factor(Sexo),
                   estado_civil = as_factor(`Estado civil`),
                   ocupacion = as_factor(Ocupación),
                   escolaridad = as_factor(Escolaridad),
                   conteo_cd = as_factor(`Conteo CD4`),
                   carga_viral = as_factor(`Carga viral`),
                   certificado_incapacidad = as_factor(`Certificado de Incapacidad para el Trabajo`),
                   dias_incapacidad = as_factor(`Dias totales otorgados de incapacidad`),
                   diagnostico_incapacidad = as_factor(`Diagnósticos asociados por incapacidad para el trabajo`),
                   causa_ausentismo = as_factor(`¿Causa mas frecuente de ausentismo en tu trabajo?`)
  )
# Cambiar el nivel "2" por "0" en toda la base de datos
abs <- abs |>
  mutate_all(~recode_factor(., `2` = "0"))

# write data in correct format to data folder ----
usethis::use_data(abs, overwrite = TRUE)