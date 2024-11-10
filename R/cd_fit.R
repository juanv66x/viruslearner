#' Fit and Evaluate Stacked Ensemble Model for CD4 Cell Count or Viral Load Outcome
#'
#' This function fits a stacked ensemble model built with pre-processing and modeling workflows.
#'
#' @param outcome The name of the outcome variable.
#' @param obj_mod1 A stacked ensemble model.
#' @param testdata The test dataset for evaluating the ensemble.
#' @param predicted Column name of the predicted variable in a regression tidy format.
#' @param mode If TRUE, regression mode is used; if FALSE, classification mode is used (default is TRUE).
#' @param show_members If TRUE, outputs the retained members of the stacked ensemble model (default is FALSE).
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
#' data("cd_test", package = "viruslearner")
#' testdata <- cd_test
#' outcome <- "cd_2023"
#' predicted <- ".pred"
#' # To view members 
#' fens_obj2 |> cd_fit(outcome, testdata, predicted, TRUE, show_members = TRUE)
#' }
cd_fit <- function(obj_mod1, outcome, testdata, predicted, mode = TRUE, show_members = TRUE) {
  if (show_members) {
    
    return(obj_mod1 |> stacks::fit_members())
  } else {
    if (mode == TRUE) {
      obj_mod1 |>
        stacks::fit_members() |>
        stacks::predict.model_stack(testdata) |>
        dplyr::bind_cols(testdata) |>
        yardstick::metric_set(yardstick::rmse, yardstick::rsq)(tidyselect::all_of(outcome), tidyselect::all_of(predicted))
    } else {
      obj_mod1 |>
        stacks::fit_members() |>
        stacks::predict.model_stack(testdata) |>
        dplyr::bind_cols(testdata) |> 
        yardstick::accuracy(tidyselect::all_of(outcome), predicted)
    }
  } 
}