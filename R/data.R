#' A stacked ensemble model of CD4 data
#'
#' This object represents a stacked ensemble model that retains 5 out of 54 possible candidate members.
#' It has a penalty of 0.0885866790410082 and a mixture of 1.
#'
#' The 2 highest weighted members are:
#' \itemize{
#'   \item \code{simple_Cubist_1_1}: Type - cubist_rules, Weight - 0.596 
#'   \item \code{normalized_neural_network_1_7}: Type - mlp, Weight - 0.222
#' }
#'
#' Members have not yet been fitted with \code{fit_members()}.
#' 
#' @format A data frame with the following columns:
#'   \describe{
#'     \item{member}{Character vector, names of ensemble members}
#'     \item{type}{Character vector, types of ensemble members}
#'     \item{weight}{Numeric vector, weights of ensemble members}
#'   }
#' @examples
#' \donttest{
#'   # Load the object
#'   data("fens_obj2", package = "viruslearner")
#'   # Print the dataset
#'   print(fens_obj2)
#' }
"fens_obj2"


#' Model Fit Results for CD4 Prediction using a Stacked Ensemble Model
#'
#' This object contains evaluation metrics for a stacked ensemble model used to 
#' predict CD4 T-lymphocyte counts in the test dataset.  The model incorporates 
#' multiple learners through ensemble stacking, achieving high predictive accuracy.
#'
#' The performance metrics, indicate the model's fit:
#' \itemize{
#'   \item RMSE: 0.232
#'   \item R²: 0.956
#' }
#'
#' These metrics suggest a low prediction error (RMSE) and a high coefficient of 
#' determination (R²), demonstrating a well-fitted model with strong predictive 
#' power for CD4 counts.
#' 
#' @format A tibble with the following columns:
#'   \describe{
#'     \item{.metric}{Character vector, indicating the evaluation metric (e.g., "rmse" or "rsq")}
#'     \item{.estimator}{Character vector, indicating the type of estimator used (e.g., "standard")}
#'     \item{.estimate}{Numeric vector, the estimated value for each metric}
#'   }
#' @examples
#' \donttest{
#'   # Load the fit object
#'   data("fens_obj1", package = "viruslearner")
#'   # Print the results
#'   print(fens_fit1)
#' }
"fens_fit1"


#' Viral Rates data set for Testing CD4 Counts Outcome
#'
#' @description Contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient recovery, column `cd_2023` is identified as the outcome variable. 
#' The dataset also contains information about variables related to adherence to 
#' antiretroviral therapy (ART) and cell recovery and viral change rates.
#'
#' @format A data frame with 31 rows and 30 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("cd_test", package = "viruslearner")
#' }
"cd_test"


#' Viral Rates data set for Training CD4 Counts Outcome
#'
#' @description Contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient recovery, column `cd_2023` is identified as the outcome variable. 
#' The dataset also contains information about variables related to adherence to 
#' antiretroviral therapy (ART) and cell recovery and viral change rates.
#'
#' @format A data frame with 56 rows and 30 variables:
#' \describe{
#'   \item{cd_2018}{CD4 count in 2018.}
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{cd_2023}{CD4 count in 2023.}
#'   \item{vl_2023}{Viral load in 2023.}
#'   \item{recovery_rate_2019}{CD4 count recovery rate from 2018 to 2019.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2023}{CD4 count recovery rate from 2023 to 2022.}
#'   \item{rr_2021_2yr}{CD4 count recovery rate from 2018 to 2021.}
#'   \item{rr_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{rr_2023_2yr}{CD4 count recovery rate from 2021 to 2023.}
#'   \item{rr_2022_3yr}{CD4 count recovery rate from 2018 to 2022.}
#'   \item{rr_2023_3yr}{CD4 count recovery rate from 2019 to 2023.}
#'   \item{rr_2023_4yr}{CD4 count recovery rate from 2018 to 2023.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021 (log10).}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022 (log10).}
#'   \item{viral_rate_2023}{Viral load rate of change from 2022 to 2023 (log10).}
#'   \item{vrate_2022_2yr}{Viral load rate of change from 2019 to 2022 (log10).}
#'   \item{vrate_2023_2yr}{Viral load rate of change from 2021 to 2023 (log10).}
#'   \item{vrate_2023_3yr}{Viral load rate of change from 2019 to 2023 (log10).}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("cd_train", package = "viruslearner")
#' }
"cd_train"
