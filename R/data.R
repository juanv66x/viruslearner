#' Viral Rates Dataset
#'
#' @description The dataset contains information about patients, specifically 
#' their CD4 T cell counts (cd_2019, cd_2021, cd_2022) and viral loads (vl_2019, 
#' vl_2021, vl_2022). For modeling patient recovery and viral load persistence 
#' or suppression, column `cd_2022` is identified as the outcome variable for 
#' patient recovery, and column `vl_2022` is identified as the outcome variable 
#' for studying viral load persistence or suppression. The dataset also contains 
#' information about variables related to adherence to antiretroviral therapy
#' (ART).
#'
#' @format A data frame with 35 rows and 17 variables:
#' \describe{
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021.}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022.}
#'   \item{viral_rate_2022_2yr}{Viral load rate of change from 2019 to 2022.}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @source \url{https://cran.r-project.org/package=viraldomain}
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("viralrates", package = "viruslearner")
#'   # Explore the dataset
#'   glimpse(viralrates)
#' }
"viralrates"


#' Viral Rates Dataset for Training Viral Load Outcome
#'
#' @description The dataset contains training observations about patients, 
#' specifically their CD4 T cell counts (cd_2019, cd_2021, cd_2022) and viral 
#' loads (vl_2019, vl_2021, vl_2022). For modeling patient recovery and viral 
#' load persistence or suppression, column `cd_2022` is identified as the 
#' outcome variable for patient recovery, and column `vl_2022` is identified as 
#' the outcome variable for studying viral load persistence or suppression. The 
#' dataset also contains information about variables related to adherence to 
#' antiretroviral therapy(ART).
#'
#' @format A data frame with 26 rows and 17 variables:
#' \describe{
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021.}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022.}
#'   \item{viral_rate_2022_2yr}{Viral load rate of change from 2019 to 2022.}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @source \url{https://cran.r-project.org/package=viraldomain}
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("vl_train", package = "viruslearner")
#'   # Explore the dataset
#'   glimpse(vl_train)
#' }
"vl_train"


#' Viral Rates Dataset for Testing Viral Load Outcome
#'
#' @description The dataset contains testing observations about patients, 
#' specifically their CD4 T cell counts (cd_2019, cd_2021, cd_2022) and viral 
#' loads (vl_2019, vl_2021, vl_2022). For modeling patient recovery and viral 
#' load persistence or suppression, column `cd_2022` is identified as the 
#' outcome variable for patient recovery, and column `vl_2022` is identified as 
#' the outcome variable for studying viral load persistence or suppression. The 
#' dataset also contains information about variables related to adherence to 
#' antiretroviral therapy(ART).
#'
#' @format A data frame with 9 rows and 17 variables:
#' \describe{
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021.}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022.}
#'   \item{viral_rate_2022_2yr}{Viral load rate of change from 2019 to 2022.}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @source \url{https://cran.r-project.org/package=viraldomain}
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("vl_test", package = "viruslearner")
#'   # Explore the dataset
#'   glimpse(vl_test)
#' }
"vl_test"


#' Viral Rates Dataset for Training CD4 Counts Outcome
#'
#' @description The dataset contains training observations about patients, 
#' specifically their CD4 T cell counts (cd_2019, cd_2021, cd_2022) and viral 
#' loads (vl_2019, vl_2021, vl_2022). For modeling patient recovery and viral 
#' load persistence or suppression, column `cd_2022` is identified as the 
#' outcome variable for patient recovery, and column `vl_2022` is identified as 
#' the outcome variable for studying viral load persistence or suppression. The 
#' dataset also contains information about variables related to adherence to 
#' antiretroviral therapy(ART).
#'
#' @format A data frame with 26 rows and 17 variables:
#' \describe{
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021.}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022.}
#'   \item{viral_rate_2022_2yr}{Viral load rate of change from 2019 to 2022.}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @source \url{https://cran.r-project.org/package=viraldomain}
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("cd_train", package = "viruslearner")
#'   # Explore the dataset
#'   glimpse(cd_train)
#' }
"cd_train"


#' Viral Rates Dataset for Testing CD4 Counts Outcome
#'
#' @description The dataset contains testing observations about patients, 
#' specifically their CD4 T cell counts (cd_2019, cd_2021, cd_2022) and viral 
#' loads (vl_2019, vl_2021, vl_2022). For modeling patient recovery and viral 
#' load persistence or suppression, column `cd_2022` is identified as the 
#' outcome variable for patient recovery, and column `vl_2022` is identified as 
#' the outcome variable for studying viral load persistence or suppression. The 
#' dataset also contains information about variables related to adherence to 
#' antiretroviral therapy(ART).
#'
#' @format A data frame with 9 rows and 17 variables:
#' \describe{
#'   \item{cd_2019}{CD4 count in 2019.}
#'   \item{vl_2019}{Viral load in 2019.}
#'   \item{cd_2021}{CD4 count in 2021.}
#'   \item{vl_2021}{Viral load in 2021.}
#'   \item{cd_2022}{CD4 count in 2022.}
#'   \item{vl_2022}{Viral load in 2022.}
#'   \item{recovery_rate_2021}{CD4 count recovery rate from 2019 to 2021.}
#'   \item{recovery_rate_2022}{CD4 count recovery rate from 2021 to 2022.}
#'   \item{recovery_rate_2022_2yr}{CD4 count recovery rate from 2019 to 2022.}
#'   \item{viral_rate_2021}{Viral load rate of change from 2019 to 2021.}
#'   \item{viral_rate_2022}{Viral load rate of change from 2021 to 2022.}
#'   \item{viral_rate_2022_2yr}{Viral load rate of change from 2019 to 2022.}
#'   \item{adherence_1}{First principal component analysis scores representing adherence to ART.}
#'   \item{adherence_2}{Second principal component analysis scores representing adherence to ART.}
#'   \item{adherence_3}{Third principal component analysis scores representing adherence to ART.}
#'   \item{adherence_4}{Fourth principal component analysis scores representing adherence to ART.}
#'   \item{adherence_5}{Fifth principal component analysis scores representing adherence to ART.}
#' }
#' @source \url{https://cran.r-project.org/package=viraldomain}
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("cd_test", package = "viruslearner")
#'   # Explore the dataset
#'   glimpse(cd_test)
#' }
"cd_test"