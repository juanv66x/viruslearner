# load required packages ----
if (!require("pacman")) install.packages("pacman") 
pacman::p_load(tidymodels, viraldomain, FactoMineR, tidyverse)

## Variables transformation
library(FactoMineR)
res_pca <- PCA(viral, graph = FALSE)
library(tidyverse)
recovery_rates <- viral |>
  mutate(
    recovery_rate_2021 = (cd_2021 - cd_2019) / cd_2019,
    recovery_rate_2022 = (cd_2022 - cd_2021) / cd_2021,
    recovery_rate_2022_2yr = (cd_2022 - cd_2019) / cd_2019,
    viral_rate_2021 = (vl_2021 - vl_2019) / (vl_2019+1),
    viral_rate_2022 = (vl_2022 - vl_2021) / (vl_2021+1),
    viral_rate_2022_2yr = (vl_2022 - vl_2019) / (vl_2019+1)
  ) |>
  mutate_all(~ . + 1) 

## Data spending
set.seed(1502)
vl_split <- initial_split(recovery_rates |> 
                            mutate(vl_2022 = log10(vl_2022)) |>
                            mutate_at('vl_2022', ~(scale(.) |> as.vector())) |>
                            bind_cols(res_pca$ind$coord) |>
                            rename_with(function(x){gsub("Dim.","adherence_",x)})
)
vl_train  <- training(vl_split)

# write data in correct format to data folder ----
usethis::use_data(vl_train, overwrite = TRUE)