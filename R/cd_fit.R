#' Fit and Evaluate Stacked Ensemble Model for CD4 Cell Count or Viral Load Outcome
#'
#' This function fits a stacked ensemble model built with pre-processing and modeling workflows.
#'
#' @param outcome The name of the outcome variable.
#' @param obj_mod1 A stacked ensemble model.
#' @param testdata The test dataset for evaluating the ensemble.
#' @param predicted Column name of the predicted variable in a regression tidy format.
#' @param mode If TRUE, regression mode is used; if FALSE, classification mode is used (default is TRUE).
#'
#' @return A tibble containing the root mean squared error (RMSE) and coefficient of determination (R2) metrics.
#' @export
#'
#' @examples
#' \donttest{
#' library(baguette)
#' library(Cubist)
#' library(rules)
#' data("cd_obj1", package = "viruslearner")
#' data("cd_test", package = "viruslearner")
#' testdata <- cd_test
#' outcome <- "cd_2023"
#' predicted <- ".pred"
#' cd_obj1 |> cd_fit(outcome, testdata, predicted, TRUE)
#' }
cd_fit <- function(obj_mod1, outcome, testdata, predicted, mode = TRUE) {
  if (mode == TRUE) {
    obj_mod1 |>
      stacks::fit_members() |>
      stacks::predict.model_stack(testdata) |>
      dplyr::bind_cols(testdata) |>
      yardstick::metric_set(yardstick::rmse, yardstick::rsq)(tidyselect::all_of(outcome), tidyselect::all_of(predicted))
  } else if (mode == FALSE) {
    obj_mod1 |>
      stacks::fit_members() |>
      stacks::predict.model_stack(testdata) |>
      dplyr::bind_cols(testdata) |> 
      #yardstick::metric_set(yardstick::accuracy, yardstick::roc_auc)(tidyselect::all_of(outcome), tidyselect::all_of(predicted))
      yardstick::accuracy(tidyselect::all_of(outcome), predicted)
  }
}