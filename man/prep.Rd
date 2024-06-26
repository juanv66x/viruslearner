% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{prep}
\alias{prep}
\title{Pre and Pos-Exposure Prophylaxis (PrEP and PEP) Educational Intervention}
\format{
A data frame with 131 rows and 34 variables:
\describe{
\item{gender}{Gender: 1 for Male, 2 for Female.}
\item{age}{Age: 1 for <=30 years, 2 for >30 years.}
\item{education}{Educational background: 1 for Mip 2, 2 for Mip 1.}
\item{maritalstatus}{Marital status: 1 for Single, 2 for Married.}
\item{institution}{Educational institution: 1 for Public, 2 for Private.}
\item{orientation}{Sexual orientation: 1 for Homosexual/Bi, 2 for Heterosexual.}
\item{knowHIV}{Knowledge about HIV: 1 for No, 2 for Yes.}
\item{knowHIVTx}{Knowledge about HIV treatment: 1 for No, 2 for Yes.}
\item{HIVtest}{HIV Testing: 1 for No, 2 for Yes.}
\item{otherSTItest}{Other STI Testing: 1 for No, 2 for Yes.}
\item{STIhistory}{STD History: 1 for No, 2 for Yes.}
\item{satisfaction}{Sexual Satisfaction: 1 for Unsatisfied, 2 for Satisfied.}
\item{condomuse}{Condom Usage: 1 for Never/Sometimes, 2 for Always.}
\item{partners}{Number of Sexual Partners: 1 for >1, 2 for 1.}
\item{nopreservpartners}{Partners without Condoms: 1 for >1, 2 for 1.}
\item{stablepartner}{Stable Partner: 1 for No, 2 for Yes.}
\item{alcohol}{Alcohol Consumption: 1 for No, 2 for Yes.}
\item{druguse}{Drug Usage: 1 for No, 2 for Yes.}
\item{lastHIVtest}{Last HIV Test: 1 for No, 2 for Yes.}
\item{knowPrEP}{Knowledge about PrEP: 1 for No, 2 for Yes.}
\item{understandPrEP}{Understanding of PrEP: 1 for No, 2 for Yes.}
\item{dailyPrEP}{Daily PrEP Usage: 1 for No, 2 for Yes.}
\item{intermittentPrEP}{Intermittent PrEP Usage: 1 for No, 2 for Yes.}
\item{PrEPinfoLocation}{Location of PrEP Information: 1 for Private Service, 2 for Public Service.}
\item{PrEPUse}{PrEP Usage: 1 for Yes, 2 for No.}
\item{PrEPorPEPprescription}{Prescription for PrEP or PEP: 1 for Yes, 2 for No.}
\item{knowPrEPorPEP}{Knowledge about PrEP or PEP: 1 for No, 2 for Yes.}
\item{sourcePrEPorPEP}{Source of Information about PrEP or PEP: 1 for Other, 2 for Healthcare Professional.}
\item{knowPEP}{Knowledge about PEP: 1 for No, 2 for Yes.}
\item{heardPEP}{Knowledge about PEP: 1 for No, 2 for Yes.}
\item{usedPEP}{PEP Usage: 1 for Yes, 2 for No.}
\item{PEPUse}{PEP Usage: 1 for Yes, 2 for No.}
\item{intervention}{Intervention status: 1 for No, 2 for Yes.}
\item{knowledge}{Intervention knowledge: 1 for Pre-intervention, 2 for Post-intervention.}
}
}
\usage{
prep
}
\description{
Contains information about participants in an educational intervention regarding knowledge and usage of Pre-Exposure Prophylaxis (PrEP) and Post-Exposure Prophylaxis (PEP) among undergraduate medical interns. It includes demographic information such as age, gender, marital status, sexual orientation, educational background, and various aspects related to knowledge, usage, and attitudes towards PrEP and PEP.
}
\examples{
\dontrun{
  # Load the dataset
  data("prep", package = "viruslearner")
  # Explore the dataset
  library(dplyr)
  dplyr::glimpse(prep)
}
}
\keyword{datasets}
