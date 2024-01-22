# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(tidymodels, here, FactoMineR, tidyverse)

## Variables transformation
viral_new <- read_csv(here::here("data-raw","viral_new.csv"))
library(FactoMineR)
res_pca <- PCA(viral_new, graph = FALSE)
library(tidyverse)
recovery_rates <- viral_new |>
  mutate(
    recovery_rate_2019 = (cd_2019 - cd_2018) / cd_2018,
    recovery_rate_2021 = (cd_2021 - cd_2019) / cd_2019,
    recovery_rate_2022 = (cd_2022 - cd_2021) / cd_2021,
    recovery_rate_2023 = (cd_2023 - cd_2022) / cd_2022,
    viral_rate_2021 = (log10(vl_2021) - log10(vl_2019)) / log10(vl_2019),
    viral_rate_2022 = (log10(vl_2022) - log10(vl_2021)) / log10(vl_2021),
    viral_rate_2023 = (log10(vl_2023) - log10(vl_2022)) / log10(vl_2022)
  )

## Data spending
set.seed(1502)
vl_split <- initial_split(recovery_rates |> 
                            mutate(vl_2023 = log10(vl_2023)) |>
                            mutate_at('vl_2023', ~(scale(.) |> as.vector())) |>
                            bind_cols(res_pca$ind$coord) |>
                            rename_with(function(x){gsub("Dim.","adherence_",x)})
)
vl_test <- testing(vl_split)

# write data in correct format to data folder ----
usethis::use_data(vl_test, overwrite = TRUE)