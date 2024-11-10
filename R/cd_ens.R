#' Build Custom Model
#'
#' This function builds and evaluates custom machine learning models based on user-defined parameters
#'
#' @param get_models If TRUE, returns a list of predefined models without grid search or pre-processing (default is FALSE).
#'
#' @return Depending on the parameters, either a list of predefined models or a data frame with model evaluation results.
#'
#' @export
#'
#' @examples
#' # Get predefined models
#' cd_ens(get_models = TRUE)
cd_ens <-   function(get_models = TRUE) {
  if (get_models) {
    # Define and return a list of models without grid search or pre-processing
    model_list <- list(
      regression_models = list(
        rf = parsnip::rand_forest(mtry = hardhat::tune(), min_n = hardhat::tune(), trees = hardhat::tune()) |> 
          parsnip::set_engine("ranger") |> 
          parsnip::set_mode("regression"),
        Cubist = parsnip::cubist_rules(committees = hardhat::tune(), neighbors = hardhat::tune()) |>
          parsnip::set_engine("Cubist"),
        SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
          parsnip::set_engine("kernlab") |>
          parsnip::set_mode("regression"),
        SVM_poly = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
          parsnip::set_engine("kernlab") |>
          parsnip::set_mode("regression"),
        KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
          parsnip::set_engine("kknn") |>
          parsnip::set_mode("regression"),
        neural_network = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
          parsnip::set_engine("nnet", MaxNWts = 2600) |>
          parsnip::set_mode("regression")
      ),
      classification_models = list(
        SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
          parsnip::set_engine("kernlab") |>
          parsnip::set_mode("classification"),
        SVM_poly = parsnip::svm_poly(cost = hardhat::tune(), degree = hardhat::tune()) |>
          parsnip::set_engine("kernlab") |>
          parsnip::set_mode("classification"),
        KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
          parsnip::set_engine("kknn") |>
          parsnip::set_mode("classification"),
        neural_network = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
          parsnip::set_engine("nnet", MaxNWts = 2600) |>
          parsnip::set_mode("classification")
      )
    )
    return(model_list)
  }
}