cd_stack <- function(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize) {
  set.seed(seed) 
  stacks() |>
    add_candidates(
      bind_rows(
        workflow_set(
          preproc = list(simple = workflow_variables(outcomes = tidyselect::all_of(outcome), predictors = everything())),
          models = list(MARS_cd = mars(prod_degree = tune()) |>
                          set_engine("earth") |>
                          set_mode("regression"),
                        CART_cd = decision_tree(cost_complexity = tune(), min_n = tune()) |>
                          set_engine("rpart") |>
                          set_mode("regression"), 
                        CART_bagged_cd = bag_tree() |> 
                          set_engine("rpart", times = 50L) |> 
                          set_mode("regression"), 
                        RF_cd = rand_forest(mtry = tune(), min_n = tune(), trees = 1000) |> 
                          set_engine("ranger") |> 
                          set_mode("regression"), 
                        boosting_cd = boost_tree(tree_depth = tune(), learn_rate = tune(), loss_reduction = tune(), min_n = tune(), sample_size = tune(), trees = tune()) |> 
                          set_engine("xgboost") |> 
                          set_mode("regression"), 
                        Cubist_cd = cubist_rules(committees = tune(), neighbors = tune()) |> 
                          set_engine("Cubist")
                        )
          ),
        workflow_set(
          preproc = list(normalized = recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                           step_log(tidyselect::all_of(viralvars), base = logbase) |>
                           step_normalize(all_predictors())),
          models = list(SVM_radial_cd = svm_rbf(cost = tune(), rbf_sigma = tune()) |>
                          set_engine("kernlab") |>
                          set_mode("regression"),
                        SVM_poly_cd = svm_poly(cost = tune(), degree = tune()) |>
                          set_engine("kernlab") |> 
                          set_mode("regression"), 
                        KNN_cd = nearest_neighbor(neighbors = tune(), dist_power = tune(), weight_func = tune()) |> 
                          set_engine("kknn") |> 
                          set_mode("regression"), 
                        neural_network_cd = mlp(hidden_units = tune(), penalty = tune(), epochs = tune()) |> 
                          set_engine("nnet", MaxNWts = 2600) |> 
                          set_mode("regression")
                        )
          ) |>
          option_add(param_info = mlp(hidden_units = tune(), penalty = tune(), epochs = tune()) |> 
                       set_engine("nnet", MaxNWts = 2600) |> 
                       set_mode("regression") |> 
                       extract_parameter_set_dials() |> 
                       update(hidden_units = hidden_units(c(1, 27))),
                     id = "normalized_neural_network_cd"), 
        workflow_set(
          preproc = list(full_quad = recipe(stats::as.formula(paste(outcome, "~ .")), data = traindata) |>
                           step_log(tidyselect::all_of(viralvars), base = logbase) |>
                           step_normalize(all_predictors())  |>
                           step_poly(all_predictors()) |> 
                           step_interact(~ all_predictors():all_predictors())
                         ), 
          models = list(linear_reg_cd = linear_reg(penalty = tune(), mixture = tune()) |> 
                          set_engine("glmnet"),
                        KNN_cd = nearest_neighbor(neighbors = tune(), dist_power = tune(), weight_func = tune()) |> 
                          set_engine("kknn") |> 
                          set_mode("regression")
                        )
          )
        ) |>
        workflow_map(
          seed = seed,
          resamples = vfold_cv(traindata, repeats = repetitions),
          grid = gridsize,
          control = control_grid(
            save_pred = TRUE,
            parallel_over = "everything",
            save_workflow = TRUE
            )
          )
      )
  }