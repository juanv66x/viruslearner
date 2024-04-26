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
    rr_2021_2yr = (cd_2021 - cd_2018) / cd_2018,
    rr_2022_2yr = (cd_2022 - cd_2019) / cd_2019,
    rr_2023_2yr = (cd_2023 - cd_2021) / cd_2021,
    rr_2022_3yr = (cd_2022 - cd_2018) / cd_2018,
    rr_2023_3yr = (cd_2023 - cd_2019) / cd_2019,
    rr_2023_4yr = (cd_2023 - cd_2018) / cd_2018,
    viral_rate_2021 = (log10(vl_2021) - log10(vl_2019)) / log10(vl_2019),
    viral_rate_2022 = (log10(vl_2022) - log10(vl_2021)) / log10(vl_2021),
    viral_rate_2023 = (log10(vl_2023) - log10(vl_2022)) / log10(vl_2022),
    vrate_2022_2yr = (log10(vl_2022) - log10(vl_2019)) / log10(vl_2019),
    vrate_2023_2yr = (log10(vl_2023) - log10(vl_2021)) / log10(vl_2021),
    vrate_2023_3yr = (log10(vl_2023) - log10(vl_2019)) / log10(vl_2019)
  )

## Data spending
set.seed(1501)
cd_split <- initial_split(recovery_rates |> 
                            mutate_at("cd_2023", ~(scale(., center = TRUE, scale = TRUE) |> as.vector())) |>
                            bind_cols(res_pca$ind$coord) |>
                            rename_with(function(x){gsub("Dim.","adherence_",x)}),
                          prop = .65
)
cd_train <- training(cd_split)

# write data in correct format to data folder ----
usethis::use_data(cd_train, overwrite = TRUE)