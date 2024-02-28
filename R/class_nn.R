#' Traina neural network model and plot variable importance
#'
#' @param hiv_data HIV data set
#' @param vip_featured Outcome variable
#' @param hu Hidden units in the model
#' @param plty Penalization
#' @param epo Training epochs in the model
#'
#' @return A variable importance plot
#' @export
#'
#' @examples
#' \donttest{
#' library(nnet)
#' data("mortality", package = "viruslearner")
#' vip_featured <- "V23"
#' hiv_data <- mortality
#' hu <- 16
#' plty <- 0.0000639
#' epo <- 720
#' set.seed(7)
#' class_nn(vip_featured, hiv_data, hu, plty, epo)
#' }
class_nn <- function(vip_featured, hiv_data, hu, plty, epo) {
  workflows::workflow() |>
    workflows::add_recipe(recipes::recipe(stats::as.formula(paste(vip_featured,"~.")), data = hiv_data) |>
                            recipes::step_dummy(recipes::all_nominal_predictors())) |>
    workflows::add_model(parsnip::mlp(hidden_units = hu, penalty = plty, epochs = epo) |>
                           parsnip::set_engine("nnet", MaxNWts = 2600) |>
                           parsnip::set_mode("classification")) |> 
    parsnip::fit(data = hiv_data) |>
    vip::vip() |>
    print()
}