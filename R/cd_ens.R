#' Build Custom Model
#'
#' This function builds and evaluates custom machine learning models based on user-defined parameters
#'
#' @param outcome The outcome variable for modeling.
#' @param traindata The training dataset for model building.
#' @param viralvars The variables related to viral data.
#' @param logbase The base for logarithmic transformation.
#' @param seed The random seed for reproducibility.
#' @param repetitions The number of repetitions for cross-validation.
#' @param gridsize The size of the hyperparameter grid for tuning.
#' @param type If TRUE, ensemble modeling is used; if FALSE, individual model building is used.
#' @param get_models If TRUE, returns a list of predefined models without grid search or pre-processing.
#'
#' @return Depending on the parameters, either a list of predefined models or a data frame with model evaluation results.
#'
#' @export
#'
#' @examples
#' data("cd_train", package = "viruslearner")
#' outcome <- "cd_2023"
#' traindata <- cd_train
#' viralvars <- c("vl_2019", "vl_2021", "vl_2022", "vl_2023")
#' logbase <- 10
#' seed <- 1501
#' repetitions <- 2
#' gridsize <- 1
#' set.seed(123)
#' # Get predefined models
#' cd_ens(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, 
#' type = FALSE, get_models = TRUE)
cd_ens <-   function(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize, type = TRUE, get_models = TRUE) {
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
  } else {
    if (type == FALSE) {
      return(
        dplyr::bind_rows(
          workflowsets::workflow_set(
            preproc = list(simple = workflows::workflow_variables(outcomes = tidyselect::all_of(outcome), predictors = tidyselect::everything())),
            models = list(rf = parsnip::rand_forest(mtry = hardhat::tune(), min_n = hardhat::tune(), trees = hardhat::tune()) |> 
                            parsnip::set_engine("ranger") |> 
                            parsnip::set_mode("regression"),
                          Cubist = parsnip::cubist_rules(committees = hardhat::tune(), neighbors = hardhat::tune()) |>
                            parsnip::set_engine("Cubist")
            )
          ),
          workflowsets::workflow_set(
            preproc = list(normalized = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                             recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                             recipes::step_normalize(recipes::all_predictors())),
            models = list(SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
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
            )
          ) |>
            workflowsets::option_add(param_info = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                                       parsnip::set_engine("nnet", MaxNWts = 2600) |>
                                       parsnip::set_mode("regression") |>
                                       tune::extract_parameter_set_dials() |>
                                       recipes::update(hidden_units = dials::hidden_units(c(1, 27))),
                                     id = "normalized_neural_network"),
          workflowsets::workflow_set(
            preproc = list(full_quad = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                             recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                             recipes::step_normalize(recipes::all_predictors())  |>
                             recipes::step_poly(recipes::all_predictors()) |>
                             recipes::step_interact(~ recipes::all_predictors():recipes::all_predictors())
            ),
            models = list(linear_reg = parsnip::linear_reg(penalty = hardhat::tune(), mixture = hardhat::tune()) |>
                            parsnip::set_engine("glmnet"),
                          KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                            parsnip::set_engine("kknn") |>
                            parsnip::set_mode("regression")
            )
          )
        ) |>
          workflowsets::workflow_map(
            seed = seed,
            resamples = rsample::vfold_cv(traindata, repeats = repetitions),
            grid = gridsize,
            control = tune::control_grid(
              save_pred = TRUE,
              parallel_over = "everything",
              save_workflow = TRUE
            )
          ) |>
          workflowsets::rank_results() |>
          as.data.frame() |>
          dplyr::mutate_if(is.numeric, round, digits = 2)
      )
    }
    if (type == TRUE) {
      return(
        stacks::stacks() |>
          stacks::add_candidates(
            dplyr::bind_rows(
              workflowsets::workflow_set(
                preproc = list(simple = workflows::workflow_variables(outcomes = tidyselect::all_of(outcome), predictors = tidyselect::everything())),
                models = list(rf = parsnip::rand_forest(mtry = hardhat::tune(), min_n = hardhat::tune(), trees = hardhat::tune()) |> 
                                parsnip::set_engine("ranger") |> 
                                parsnip::set_mode("regression"),
                              Cubist = parsnip::cubist_rules(committees = hardhat::tune(), neighbors = hardhat::tune()) |>
                                parsnip::set_engine("Cubist")
                )
              ),
              workflowsets::workflow_set(
                preproc = list(normalized = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                                 recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                                 recipes::step_normalize(recipes::all_predictors())),
                models = list(SVM_radial = parsnip::svm_rbf(cost = hardhat::tune(), rbf_sigma = hardhat::tune()) |>
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
                )
              ) |>
                workflowsets::option_add(param_info = parsnip::mlp(hidden_units = hardhat::tune(), penalty = hardhat::tune(), epochs = hardhat::tune()) |>
                                           parsnip::set_engine("nnet", MaxNWts = 2600) |>
                                           parsnip::set_mode("regression") |>
                                           tune::extract_parameter_set_dials() |>
                                           recipes::update(hidden_units = dials::hidden_units(c(1, 27))),
                                         id = "normalized_neural_network"),
              workflowsets::workflow_set(
                preproc = list(full_quad = recipes::recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                                 recipes::step_log(tidyselect::all_of(viralvars), base = logbase) |>
                                 recipes::step_normalize(recipes::all_predictors())  |>
                                 recipes::step_poly(recipes::all_predictors()) |>
                                 recipes::step_interact(~ recipes::all_predictors():recipes::all_predictors())
                ),
                models = list(linear_reg = parsnip::linear_reg(penalty = hardhat::tune(), mixture = hardhat::tune()) |>
                                parsnip::set_engine("glmnet"),
                              KNN = parsnip::nearest_neighbor(neighbors = hardhat::tune(), dist_power = hardhat::tune(), weight_func = hardhat::tune()) |>
                                parsnip::set_engine("kknn") |>
                                parsnip::set_mode("regression")
                )
              )
            ) |>
              workflowsets::workflow_map(
                seed = seed,
                resamples = rsample::vfold_cv(traindata, repeats = repetitions),
                grid = gridsize,
                control = tune::control_grid(
                  save_pred = TRUE,
                  parallel_over = "everything",
                  save_workflow = TRUE
                )
              )
          ) |>
          stacks::blend_predictions(penalty = 10^seq(-2, -0.5, length = 20))
      )
    }
  }
}