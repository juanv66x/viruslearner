#' Fit and Evaluate Stacked Ensemble Model for CD4 Cell Count or Viral Load Outcome
#'
#' This function fits a stacked ensemble model built with pre-processing and modeling workflows.
#'
#' @param obj_mod1 A stacked ensemble model.
#' @param show_members If TRUE, outputs the retained members of the stacked ensemble model.
#'
#' @return A tibble containing the root mean squared error (RMSE) and coefficient of determination (R2) metrics,
#' or a summary of the model members.
#' 
#' @export
#'
#' @examples
#' \donttest{
#' library(Cubist)
#' library(kernlab)
#' library(kknn)
#' library(ranger)
#' library(rules)
#' data("fens_obj2", package = "viruslearner")
#' fens_obj2 |> cd_fit(show_members = TRUE)
#' }
cd_fit <- function(obj_mod1, show_members = TRUE) {
  if (show_members) {
    
    return(obj_mod1 |> stacks::fit_members())
  } 
}