#' Viral New data set
#'
#' @description Contains information about patients, specifically 
#' their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, cd_2023) and 
#' viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling patient 
#' recovery and viral load persistence or suppression, column `cd_2023` is 
#' identified as the outcome variable for CD4 cell counts, and column `vl_2023` 
#' is identified as the outcome variable for viral load. 
#'
#' @format A data frame with 87 rows and 9 variables:
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
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("viral_new", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(viral_new)
#' }
"viral_new"


#' Viral Rates data set
#'
#' @description Contains information about patients, specifically 
#' their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, cd_2023) and 
#' viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling patient 
#' recovery and viral load persistence or suppression, column `cd_2023` is 
#' identified as the outcome variable for CD4 cell counts, and column `vl_2023` 
#' is identified as the outcome variable for viral load. The data also 
#' contains information about variables related to adherence to antiretroviral 
#' therapy (ART) and cell recovery and viral change rates.
#'
#' @format A data frame with 87 rows and 30 variables:
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
#'   data("viralrates", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(viralrates)
#' }
"viralrates"


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
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(cd_train)
#' }
"cd_train"


#' Viral Rates data set for Training Viral Load Outcome
#'
#' @description Contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient viral load persistence or suppression, column `vl_2023` is 
#' identified as the outcome variable. The dataset also contains information 
#' about variables related to adherence to antiretroviral therapy (ART) and cell 
#' recovery and viral change rates.
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
#'   data("vl_train", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(vl_train)
#' }
"vl_train"


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
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(cd_test)
#' }
"cd_test"


#' Viral Rates data set for Testing Viral Load Outcome
#'
#' @description Contains information about patients, 
#' specifically their CD4 T cell counts (cd_2018, cd_2019, cd_2021, cd_2022, 
#' cd_2023) and viral loads (vl_2019, vl_2021, vl_2022, vl_2023). For modeling 
#' patient viral load persistence or suppression, column `vl_2023` is 
#' identified as the outcome variable. The dataset also contains information 
#' about variables related to adherence to antiretroviral therapy (ART) and cell 
#' recovery and viral change rates.
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
#'   data("vl_test", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(vl_test)
#' }
"vl_test"


#' Cardiovascular Risk Study Data Set in Sero Positive Population
#'
#' @description Contains information from a cardiovascular risk study conducted in a seropositive population. It includes demographic variables such as sex (Sexo), age (Edad), marital status (Estado_civil), education level (Escolaridad), and health-related variables such as hypertension (HAS), diabetes mellitus (DM), smoking status (Tabaquismo), blood pressure measurements (PAS, PAD), lipid profile (HDL, ColesterolT, Trigliceridos), viral load (CargaViral), CD4 count (CD4), and the cardiovascular risk (RCV).
#'
#' @format A data frame with 293 rows and 16 variables:
#' \describe{
#'   \item{Sexo}{Sex of the individual (1 = male, 2 = female).}
#'   \item{Edad}{Age of the individual.}
#'   \item{Estado_civil}{Marital status (1 = single, 2 = married, 3 = divorced).}
#'   \item{Escolaridad}{Education level (1 = primary, 2 = secondary, 3 = high school, 4 = technical, 5 = undergraduate, 6 = postgraduate).}
#'   \item{HAS}{Hypertension status (1 = yes, 2 = no).}
#'   \item{DM}{Diabetes mellitus status (1 = yes, 2 = no).}
#'   \item{Tabaquismo}{Smoking status (1 = yes, 2 = no).}
#'   \item{Cigarros}{Number of cigarettes smoked per day.}
#'   \item{PAS}{Systolic blood pressure.}
#'   \item{PAD}{Diastolic blood pressure.}
#'   \item{HDL}{High-density lipoprotein cholesterol.}
#'   \item{ColesterolT}{Total cholesterol level.}
#'   \item{Trigliceridos}{Triglyceride level.}
#'   \item{CargaViral}{Viral load status (1 = detectable, 2 = undetectable).}
#'   \item{CD4}{CD4 count status (1 = low, 2 = normal).}
#'   \item{RCV}{Cardiovascular risk status (1 = low, 2 = moderate/high).}
#' }
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("rcv", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(rcv)
#' }
"rcv"


#' Pre and Pos-Exposure Prophylaxis (PrEP and PEP) Educational Intervention
#'
#' @description Contains information about participants in an educational intervention regarding knowledge and usage of Pre-Exposure Prophylaxis (PrEP) and Post-Exposure Prophylaxis (PEP) among undergraduate medical interns. It includes demographic information such as age, gender, marital status, sexual orientation, educational background, and various aspects related to knowledge, usage, and attitudes towards PrEP and PEP.
#'
#' @format A data frame with 131 rows and 34 variables:
#' \describe{
#'   \item{gender}{Gender: 1 for Male, 2 for Female.}
#'   \item{age}{Age: 1 for <=30 years, 2 for >30 years.}
#'   \item{education}{Educational background: 1 for Mip 2, 2 for Mip 1.}
#'   \item{maritalstatus}{Marital status: 1 for Single, 2 for Married.}
#'   \item{institution}{Educational institution: 1 for Public, 2 for Private.}
#'   \item{orientation}{Sexual orientation: 1 for Homosexual/Bi, 2 for Heterosexual.}
#'   \item{knowHIV}{Knowledge about HIV: 1 for No, 2 for Yes.}
#'   \item{knowHIVTx}{Knowledge about HIV treatment: 1 for No, 2 for Yes.}
#'   \item{HIVtest}{HIV Testing: 1 for No, 2 for Yes.}
#'   \item{otherSTItest}{Other STI Testing: 1 for No, 2 for Yes.}
#'   \item{STIhistory}{STD History: 1 for No, 2 for Yes.}
#'   \item{satisfaction}{Sexual Satisfaction: 1 for Unsatisfied, 2 for Satisfied.}
#'   \item{condomuse}{Condom Usage: 1 for Never/Sometimes, 2 for Always.}
#'   \item{partners}{Number of Sexual Partners: 1 for >1, 2 for 1.}
#'   \item{nopreservpartners}{Partners without Condoms: 1 for >1, 2 for 1.}
#'   \item{stablepartner}{Stable Partner: 1 for No, 2 for Yes.}
#'   \item{alcohol}{Alcohol Consumption: 1 for No, 2 for Yes.}
#'   \item{druguse}{Drug Usage: 1 for No, 2 for Yes.}
#'   \item{lastHIVtest}{Last HIV Test: 1 for No, 2 for Yes.}
#'   \item{knowPrEP}{Knowledge about PrEP: 1 for No, 2 for Yes.}
#'   \item{understandPrEP}{Understanding of PrEP: 1 for No, 2 for Yes.}
#'   \item{dailyPrEP}{Daily PrEP Usage: 1 for No, 2 for Yes.}
#'   \item{intermittentPrEP}{Intermittent PrEP Usage: 1 for No, 2 for Yes.}
#'   \item{PrEPinfoLocation}{Location of PrEP Information: 1 for Private Service, 2 for Public Service.}
#'   \item{PrEPUse}{PrEP Usage: 1 for Yes, 2 for No.}
#'   \item{PrEPorPEPprescription}{Prescription for PrEP or PEP: 1 for Yes, 2 for No.}
#'   \item{knowPrEPorPEP}{Knowledge about PrEP or PEP: 1 for No, 2 for Yes.}
#'   \item{sourcePrEPorPEP}{Source of Information about PrEP or PEP: 1 for Other, 2 for Healthcare Professional.}
#'   \item{knowPEP}{Knowledge about PEP: 1 for No, 2 for Yes.}
#'   \item{heardPEP}{Knowledge about PEP: 1 for No, 2 for Yes.}
#'   \item{usedPEP}{PEP Usage: 1 for Yes, 2 for No.}
#'   \item{PEPUse}{PEP Usage: 1 for Yes, 2 for No.}
#'   \item{intervention}{Intervention status: 1 for No, 2 for Yes.}
#'   \item{knowledge}{Intervention knowledge: 1 for Pre-intervention, 2 for Post-intervention.}
#' }
#' @examples
#' \dontrun{
#'   # Load the dataset
#'   data("prep", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(prep)
#' }
"prep"


#' Absenteeism Study Data Set in a Sero Positive Population
#'
#' @description Contains information about work absenteeism in a sero-positive population. It includes variables representing different risk factors for absenteeism, where 0 indicates no or low risk factors, and 1 indicates the presence of risk factors for each variable in the population.
#'
#' @format A data frame with 280 rows and 11 variables:
#' \describe{
#'   \item{edad}{Age: 0 for no/low risk, 1 for risk factor present.}
#'   \item{sexo}{Gender: 0 for no/low risk, 1 for risk factor present.}
#'   \item{estado_civil}{Marital status: 0 for no/low risk, 1 for risk factor present.}
#'   \item{ocupacion}{Occupation: 0 for no/low risk, 1 for risk factor present.}
#'   \item{escolaridad}{Education level: 0 for no/low risk, 1 for risk factor present.}
#'   \item{conteo_cd}{Count of chronic diseases: 0 for no/low risk, 1 for risk factor present.}
#'   \item{carga_viral}{Viral load: 0 for no/low risk, 1 for risk factor present.}
#'   \item{certificado_incapacidad}{Disability certificate: 0 for no/low risk, 1 for risk factor present.}
#'   \item{dias_incapacidad}{Days of disability: 0 for no/low risk, 1 for risk factor present.}
#'   \item{diagnostico_incapacidad}{Disability diagnosis: 0 for no/low risk, 1 for risk factor present.}
#'   \item{causa_ausentismo}{Cause of absenteeism: 0 for no/low risk, 1 for risk factor present.}
#' }
#' @examples
#' \donttest{
#'   # Load the dataset
#'   data("abs", package = "viruslearner")
#'   # Explore the dataset
#'   library(dplyr)
#'   dplyr::glimpse(abs)
#' }
"abs"

#' A stacked ensemble model of CD4 data
#'
#' This object represents a stacked ensemble model that retains 4 out of 9 possible candidate members.
#' It has a penalty of 0.0615848211066026 and a mixture of 1.
#'
#' The 4 highest weighted members are:
#' \itemize{
#'   \item \code{simple_Cubist_1_1}: Type - cubist_rules, Weight - 0.628
#'   \item \code{simple_CART_bagged_1_1}: Type - bag_tree, Weight - 0.281
#'   \item \code{full_quad_linear_reg_1_1}: Type - linear_reg, Weight - 0.0743
#'   \item \code{normalized_SVM_poly_1_1}: Type - svm_poly, Weight - 0.0221
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
#'   data("obj_mod1", package = "viruslearner")
#'   # Print the dataset
#'   print(obj_mod1)
#' }
"obj_mod1"



#' A screening model object of rcv data
#'
#' This object represents a model screening generated using the viruslearner package. It contains information about the different competing models, their configurations, performance metrics, and rankings.
#'
#' The model consists of multiple workflows (\code{wflow_id}) with different configurations (\code{.config}). For each workflow, there are metrics such as accuracy, ROC-AUC (\code{.metric}), mean performance (\code{mean}), standard error (\code{std_err}), number of iterations (\code{n}), preprocessor used (\code{preprocessor}), and the model type (\code{model}).
#'
#' The model rankings (\code{rank}) provide insights into the relative performance of different workflows and configurations within the ensemble.
#'
#' @format A data frame with the following columns:
#'   \describe{
#'     \item{wflow_id}{Character vector, unique identifier for each workflow}
#'     \item{.config}{Character vector, configuration details for each workflow}
#'     \item{.metric}{Character vector, performance metric (e.g., accuracy, ROC-AUC)}
#'     \item{mean}{Numeric vector, mean performance metric}
#'     \item{std_err}{Numeric vector, standard error of the mean}
#'     \item{n}{Numeric vector, number of iterations or repetitions}
#'     \item{preprocessor}{Character vector, preprocessor used in the workflow}
#'     \item{model}{Character vector, type of model used in the workflow}
#'     \item{rank}{Numeric vector, rank of the workflow based on performance}
#'   }
#' @examples
#' \donttest{
#'   # Load the object
#'   data("obj_md2", package = "viruslearner")
#'   # Print the dataset
#'   print(obj_mod2)
#' }
"obj_mod2"


#' A stacked ensemble model of abs data 
#'
#' This object represents a stacked ensemble model that retains 2 out of 4 possible candidate members.
#' It has a penalty of 0.0206913808111479 and a mixture of 1.
#'
#' The 2 highest weighted members are:
#' \itemize{
#'   \item \code{cate_SVM_poly_1_1}: Type - svm_poly, Weight - 4.85
#'   \item \code{cate_KNN_1_1 }: Type - nearest_neighbor, Weight - 1.50
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
#'   data("obj_mod3", package = "viruslearner")
#'   # Print the dataset
#'   print(obj_mod3)
#' }
"obj_mod3"


#' A screening model object of abs data
#'
#' It contains information about the different competing models, their configurations, performance metrics, and rankings.
#'
#' The model consists of multiple workflows (\code{wflow_id}) with different configurations (\code{.config}). For each workflow, there are metrics such as accuracy, ROC-AUC (\code{.metric}), mean performance (\code{mean}), standard error (\code{std_err}), number of iterations (\code{n}), preprocessor used (\code{preprocessor}), and the model type (\code{model}).
#'
#' The model rankings (\code{rank}) provide insights into the relative performance of different workflows and configurations within the ensemble.
#'
#' @format A data frame with the following columns:
#'   \describe{
#'     \item{wflow_id}{Character vector, unique identifier for each workflow}
#'     \item{.config}{Character vector, configuration details for each workflow}
#'     \item{.metric}{Character vector, performance metric (e.g., accuracy, ROC-AUC)}
#'     \item{mean}{Numeric vector, mean performance metric}
#'     \item{std_err}{Numeric vector, standard error of the mean}
#'     \item{n}{Numeric vector, number of iterations or repetitions}
#'     \item{preprocessor}{Character vector, preprocessor used in the workflow}
#'     \item{model}{Character vector, type of model used in the workflow}
#'     \item{rank}{Numeric vector, rank of the workflow based on performance}
#'   }
#' @examples
#' \donttest{
#'   # Load the object
#'   data("obj_mod4", package = "viruslearner")
#'   # Print the dataset
#'   print(obj_mod4)
#' }
"obj_mod4"


#' A stacked ensemble model of prep data 
#'
#' This object represents a stacked ensemble model that retains 2 out of 4 possible candidate members.
#' It has a penalty of 0.01 and a mixture of 1.
#'
#' The 2 highest weighted members are:
#' \itemize{
#'   \item \code{cate_neural_network_1_1}: Type - mlp, Weight - 5.65
#'   \item \code{cate_svm_poly_1_1 }: Type - svm_poly, Weight - 2.40
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
#'   data("obj_mod5", package = "viruslearner")
#'   # Print the dataset
#'   print(obj_mod5)
#' }
"obj_mod5"