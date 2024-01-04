## Viral data
library(tidymodels)
tidymodels_prefer()
data("viral", package = "viraldomain")
glimpse(viral)
# Rows: 35
# Columns: 6
# $ cd_2019 <dbl> 824, 169, 342, 423, 441, 507, 559, 173, 764, 780, 244, 527, 417, 800, 602, 494, 345, 780, 780, 527, 556, 55…
# $ vl_2019 <dbl> 40, 11388, 38961, 40, 75, 4095, 103, 11388, 46, 103, 11388, 40, 0, 11388, 0, 4095, 40, 93, 49, 49, 49, 4095…
# $ cd_2021 <dbl> 992, 275, 331, 454, 479, 553, 496, 230, 605, 432, 170, 670, 238, 238, 634, 422, 429, 513, 327, 465, 479, 66…
# $ vl_2021 <dbl> 80, 1690, 5113, 71, 289, 3063, 0, 262, 0, 15089, 13016, 1513, 60, 60, 49248, 159308, 56, 0, 516675, 49, 237…
# $ cd_2022 <dbl> 700, 127, 127, 547, 547, 547, 777, 149, 628, 614, 253, 918, 326, 326, 574, 361, 253, 726, 659, 596, 427, 44…
# $ vl_2022 <dbl> 0, 0, 53250, 0, 40, 1901, 0, 955, 0, 0, 0, 0, 40, 0, 49248, 159308, 56, 0, 516675, 49, 237, 0, 23601, 0, 40…
#
# The dataset provided contains information about patients, specifically their 
# CD4 T cell counts (cd_2019, cd_2021, cd_2022) and viral loads (vl_2019, 
# vl_2021, vl_2022). For modeling patient recovery and viral load persistence or 
# suppression, column cd_2022 is identified as the outcome variable for patient 
# recovery and column vl_2022 is identified as the outcome variable for studying 
# viral load persistence or suppression. The rest of the variables will serve as 
# predictors in each case.


## Variables transformation
library(tidyverse)
recovery_rates <- viral |>
  mutate(
    recovery_rate_2021 = (cd_2021 - cd_2019) / cd_2019,
    recovery_rate_2022 = (cd_2022 - cd_2021) / cd_2021,
    recovery_rate_2022_2yr = (cd_2022 - cd_2019) / cd_2019,
    viral_rate_2021 = (vl_2021 - vl_2019) / (vl_2019+1),
    viral_rate_2022 = (vl_2022 - vl_2021) / (vl_2021+1),
    viral_rate_2022_2yr = (vl_2022 - vl_2019) / (vl_2019+1)
  ) |>
  mutate_all(~ . + 1)
glimpse(recovery_rates)
# Rows: 35
# Columns: 12
# $ cd_2019                <dbl> 825, 170, 343, 424, 442, 508, 560, 174, 765, 781, 245, 528, 418, 801, 603, 495, 346, 781, 78…
# $ vl_2019                <dbl> 41, 11389, 38962, 41, 76, 4096, 104, 11389, 47, 104, 11389, 41, 1, 11389, 1, 4096, 41, 94, 5…
# $ cd_2021                <dbl> 993, 276, 332, 455, 480, 554, 497, 231, 606, 433, 171, 671, 239, 239, 635, 423, 430, 514, 32…
# $ vl_2021                <dbl> 81, 1691, 5114, 72, 290, 3064, 1, 263, 1, 15090, 13017, 1514, 61, 61, 49249, 159309, 57, 1, …
# $ cd_2022                <dbl> 701, 128, 128, 548, 548, 548, 778, 150, 629, 615, 254, 919, 327, 327, 575, 362, 254, 727, 66…
# $ vl_2022                <dbl> 1, 1, 53251, 1, 41, 1902, 1, 956, 1, 1, 1, 1, 41, 1, 49249, 159309, 57, 1, 516676, 50, 238, …
# $ recovery_rate_2021     <dbl> 1.2038835, 1.6272189, 0.9678363, 1.0732861, 1.0861678, 1.0907298, 0.8872987, 1.3294798, 0.79…
# $ recovery_rate_2022     <dbl> 0.7056452, 0.4618182, 0.3836858, 1.2048458, 1.1419624, 0.9891501, 1.5665323, 0.6478261, 1.03…
# $ recovery_rate_2022_2yr <dbl> 0.8495146, 0.7514793, 0.3713450, 1.2931442, 1.2403628, 1.0788955, 1.3899821, 0.8612717, 0.82…
# $ viral_rate_2021        <dbl> 1.975610e+00, 1.484766e-01, 1.312561e-01, 1.756098e+00, 3.815789e+00, 7.480469e-01, 9.615385…
# $ viral_rate_2022        <dbl> 1.234568e-02, 5.913661e-04, 1.041279e+01, 1.388889e-02, 1.413793e-01, 6.207572e-01, 1.000000…
# $ viral_rate_2022_2yr    <dbl> 2.439024e-02, 8.780402e-05, 1.366742e+00, 2.439024e-02, 5.394737e-01, 4.643555e-01, 9.615385…


## Data spending
set.seed(1501)
cd_split <- initial_split(recovery_rates |> 
                            mutate(cd_2022 = scale(cd_2022, center = TRUE, scale = TRUE))
                          )
cd_train <- training(cd_split)
cd_test  <- testing(cd_split)
set.seed(1502)
cd_folds <- vfold_cv(cd_train, repeats = 5)

set.seed(1503)
vl_split <- initial_split(recovery_rates |> 
                            mutate(vl_2022 = scale(log10(vl_2022), center = TRUE, scale = TRUE))
                          )
vl_train <- training(vl_split)
vl_test  <- testing(vl_split)
set.seed(1504)
vl_folds <- vfold_cv(vl_train, repeats = 5)


## Recipes
normalized_cd <- recipe(cd_2022 ~ ., data = cd_train) |>
  step_log(starts_with(c("vl", "viral")), base = 10) |>
  step_normalize(all_predictors()) 
poly_cd <- normalized_cd |> 
  step_poly(all_predictors()) |> 
  step_interact(~ all_predictors():all_predictors())

normalized_vl <- recipe(vl_2022 ~ ., data = vl_train) |>
  step_log(starts_with(c("vl", "viral")), base = 10) |>
  step_normalize(all_predictors()) 
poly_vl <- normalized_vl |> 
  step_poly(all_predictors()) |> 
  step_interact(~ all_predictors():all_predictors())


## Models
library(rules)
library(baguette)
library(xgboost)
library(kknn)
library(glmnet)

linear_reg_spec <- linear_reg(penalty = tune(), mixture = tune()) |> 
  set_engine("glmnet")

nnet_spec <- mlp(hidden_units = tune(), penalty = tune(), epochs = tune()#, 
                 #dropout = tune(), activation = tune(), learn_rate = tune()
                 ) |> 
  set_engine("nnet", MaxNWts = 2600) |> 
  set_mode("regression")

mars_spec <- mars(prod_degree = tune()#, num_terms = tune(), 
                  #prune_method = tune()
                  ) |>  
  set_engine("earth") |> 
  set_mode("regression")

svm_r_spec <- svm_rbf(cost = tune(), rbf_sigma = tune()#, margin = tune()
                      ) |> 
  set_engine("kernlab") |> 
  set_mode("regression")

svm_p_spec <- svm_poly(cost = tune(), degree = tune()#, scale_factor = tune(),
                       #margin = tune()
                       ) |> 
  set_engine("kernlab") |> 
  set_mode("regression")

knn_spec <- nearest_neighbor(neighbors = tune(), dist_power = tune(), 
                             weight_func = tune()) |> 
  set_engine("kknn") |> 
  set_mode("regression")

cart_spec <- decision_tree(cost_complexity = tune(), min_n = tune()#, 
                           #tree_depth = tune()
                           ) |> 
  set_engine("rpart") |> 
  set_mode("regression")

bag_cart_spec <- bag_tree(#tree_depth = tune(), class_cost = tune(), 
                          #cost_complexity = 0, min_n = 2
  ) |> 
  set_engine("rpart", times = 50L) |> 
  set_mode("regression")

rf_spec <- rand_forest(mtry = tune(), min_n = tune(), trees = 1000) |> 
  set_engine("ranger") |> 
  set_mode("regression")

xgb_spec <- boost_tree(tree_depth = tune(), learn_rate = tune(), #mtry = tune(),
                       loss_reduction = tune(), min_n = tune(),
                       sample_size = tune(), trees = tune()#, 
                       #stop_iter = tune()
                       ) |> 
  set_engine("xgboost") |> 
  set_mode("regression")

cubist_spec <- cubist_rules(committees = tune(), neighbors = tune()#, 
                            #max_rules = tune()
                            ) |> 
  set_engine("Cubist") 

nnet_param <- nnet_spec |> 
  extract_parameter_set_dials() |> 
  update(hidden_units = hidden_units(c(1, 27)))


## Workflowsets
norm_wfl_cd <- workflow_set(
    preproc = list(normalized = normalized_cd), 
    models = list(SVM_radial_cd = svm_r_spec, SVM_poly_cd = svm_p_spec, 
                  KNN_cd = knn_spec, neural_network_cd = nnet_spec)
  )
norm_wfl_cd
## A workflow set/tibble: 4 × 4
#  wflow_id                     info             option    result    
#  <chr>                        <list>           <list>    <list>    
#1 normalized_SVM_radial_cd     <tibble [1 × 4]> <opts[0]> <list [0]>
#2 normalized_SVM_poly_cd       <tibble [1 × 4]> <opts[0]> <list [0]>
#3 normalized_KNN_cd            <tibble [1 × 4]> <opts[0]> <list [0]>
#4 normalized_neural_network_cd <tibble [1 × 4]> <opts[0]> <list [0]>
norm_wfl_cd |> extract_workflow(id = "normalized_SVM_radial_cd")
# ══ Workflow ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════
# Preprocessor: Recipe
# Model: svm_rbf()
# 
# ── Preprocessor ─────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 2 Recipe Steps
# 
# • step_log()
# • step_normalize()
# 
# ── Model ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# Radial Basis Function Support Vector Machine Model Specification (regression)
# 
# Main Arguments:
#   cost = tune()
# rbf_sigma = tune()
# margin = tune()
# 
# Computational engine: kernlab 
norm_wfl_cd <- norm_wfl_cd |>
  option_add(param_info = nnet_param, id = "normalized_neural_network_cd")
norm_wfl_cd
## A workflow set/tibble: 4 × 4
#  wflow_id                     info             option    result    
#  <chr>                        <list>           <list>    <list>    
#1 normalized_SVM_radial_cd     <tibble [1 × 4]> <opts[0]> <list [0]>
#2 normalized_SVM_poly_cd       <tibble [1 × 4]> <opts[0]> <list [0]>
#3 normalized_KNN_cd            <tibble [1 × 4]> <opts[0]> <list [0]>
#4 normalized_neural_network_cd <tibble [1 × 4]> <opts[1]> <list [0]>
   
norm_wfl_vl <- workflow_set(
  preproc = list(normalized = normalized_vl), 
  models = list(SVM_radial_vl = svm_r_spec, SVM_poly_vl = svm_p_spec, 
                KNN_vl = knn_spec, neural_network_vl = nnet_spec)
  )
norm_wfl_vl
## A workflow set/tibble: 4 × 4
#  wflow_id                     info             option    result    
#  <chr>                        <list>           <list>    <list>    
#1 normalized_SVM_radial_vl     <tibble [1 × 4]> <opts[0]> <list [0]>
#2 normalized_SVM_poly_vl       <tibble [1 × 4]> <opts[0]> <list [0]>
#3 normalized_KNN_vl            <tibble [1 × 4]> <opts[0]> <list [0]>
#4 normalized_neural_network_vl <tibble [1 × 4]> <opts[0]> <list [0]>
norm_wfl_vl |> extract_workflow(id = "normalized_SVM_poly_vl")
# ══ Workflow ═════════════════════════════════════════════════════════════════════════════════════════════════════════════════
# Preprocessor: Recipe
# Model: svm_poly()
# 
# ── Preprocessor ─────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 2 Recipe Steps
# 
# • step_log()
# • step_normalize()
# 
# ── Model ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# Polynomial Support Vector Machine Model Specification (regression)
# 
# Main Arguments:
#   cost = tune()
# degree = tune()
# scale_factor = tune()
# margin = tune()
# 
# Computational engine: kernlab 
norm_wfl_vl <- norm_wfl_vl |>
  option_add(param_info = nnet_param, id = "normalized_neural_network_vl")
norm_wfl_vl
## A workflow set/tibble: 4 × 4
#  wflow_id                     info             option    result    
#  <chr>                        <list>           <list>    <list>    
#1 normalized_SVM_radial_vl     <tibble [1 × 4]> <opts[0]> <list [0]>
#2 normalized_SVM_poly_vl       <tibble [1 × 4]> <opts[0]> <list [0]>
#3 normalized_KNN_vl            <tibble [1 × 4]> <opts[0]> <list [0]>
#4 normalized_neural_network_vl <tibble [1 × 4]> <opts[1]> <list [0]>

model_vars_cd <- workflow_variables(outcomes = cd_2022, 
                                    predictors = everything())
no_pre_proc_cd <- workflow_set(
  preproc = list(simple = model_vars_cd), 
  models = list(MARS_cd = mars_spec, CART_cd = cart_spec, 
                CART_bagged_cd = bag_cart_spec, RF_cd = rf_spec, 
                boosting_cd = xgb_spec, Cubist_cd = cubist_spec)
  )
no_pre_proc_cd
## A workflow set/tibble: 6 × 4
#  wflow_id              info             option    result    
#  <chr>                 <list>           <list>    <list>    
#1 simple_MARS_cd        <tibble [1 × 4]> <opts[0]> <list [0]>
#2 simple_CART_cd        <tibble [1 × 4]> <opts[0]> <list [0]>
#3 simple_CART_bagged_cd <tibble [1 × 4]> <opts[0]> <list [0]>
#4 simple_RF_cd          <tibble [1 × 4]> <opts[0]> <list [0]>
#5 simple_boosting_cd    <tibble [1 × 4]> <opts[0]> <list [0]>
#6 simple_Cubist_cd      <tibble [1 × 4]> <opts[0]> <list [0]>

model_vars_vl <- workflow_variables(outcomes = vl_2022, 
                                    predictors = everything())
no_pre_proc_vl <- workflow_set(
  preproc = list(simple = model_vars_vl), 
  models = list(MARS_vl = mars_spec, CART_vl = cart_spec, 
                CART_bagged_vl = bag_cart_spec, RF_vl = rf_spec, 
                boosting_vl = xgb_spec, Cubist_vl = cubist_spec)
  )
no_pre_proc_vl
## A workflow set/tibble: 6 × 4
#  wflow_id              info             option    result    
#  <chr>                 <list>           <list>    <list>    
#1 simple_MARS_vl        <tibble [1 × 4]> <opts[0]> <list [0]>
#2 simple_CART_vl        <tibble [1 × 4]> <opts[0]> <list [0]>
#3 simple_CART_bagged_vl <tibble [1 × 4]> <opts[0]> <list [0]>
#4 simple_RF_vl          <tibble [1 × 4]> <opts[0]> <list [0]>
#5 simple_boosting_vl    <tibble [1 × 4]> <opts[0]> <list [0]>
#6 simple_Cubist_vl      <tibble [1 × 4]> <opts[0]> <list [0]>

with_features_cd <- workflow_set(
  preproc = list(full_quad = poly_cd), 
  models = list(linear_reg_cd = linear_reg_spec, KNN_cd = knn_spec)
  )

with_features_vl <- workflow_set(
  preproc = list(full_quad = poly_vl), 
  models = list(linear_reg_vl = linear_reg_spec, KNN_vl = knn_spec)
)

all_workflows_cd <- bind_rows(no_pre_proc_cd, norm_wfl_cd, with_features_cd) |> 
  # Make the workflow ID's a little more simple: 
  mutate(wflow_id = gsub("(simple_)|(normalized_)", "", wflow_id))
all_workflows_cd
## A workflow set/tibble: 12 × 4
#  wflow_id                info             option    result    
#  <chr>                   <list>           <list>    <list>    
# 1 MARS_cd                 <tibble [1 × 4]> <opts[0]> <list [0]>
# 2 CART_cd                 <tibble [1 × 4]> <opts[0]> <list [0]>
# 3 CART_bagged_cd          <tibble [1 × 4]> <opts[0]> <list [0]>
# 4 RF_cd                   <tibble [1 × 4]> <opts[0]> <list [0]>
# 5 boosting_cd             <tibble [1 × 4]> <opts[0]> <list [0]>
# 6 Cubist_cd               <tibble [1 × 4]> <opts[0]> <list [0]>
# 7 SVM_radial_cd           <tibble [1 × 4]> <opts[0]> <list [0]>
# 8 SVM_poly_cd             <tibble [1 × 4]> <opts[0]> <list [0]>
# 9 KNN_cd                  <tibble [1 × 4]> <opts[0]> <list [0]>
#10 neural_network_cd       <tibble [1 × 4]> <opts[1]> <list [0]>
#11 full_quad_linear_reg_cd <tibble [1 × 4]> <opts[0]> <list [0]>
#12 full_quad_KNN_cd        <tibble [1 × 4]> <opts[0]> <list [0]>

all_workflows_vl <- bind_rows(no_pre_proc_vl, norm_wfl_vl, with_features_vl) |> 
  mutate(wflow_id = gsub("(simple_)|(normalized_)", "", wflow_id))
all_workflows_vl
## A workflow set/tibble: 12 × 4
#  wflow_id                info             option    result    
#  <chr>                   <list>           <list>    <list>    
# 1 MARS_vl                 <tibble [1 × 4]> <opts[0]> <list [0]>
# 2 CART_vl                 <tibble [1 × 4]> <opts[0]> <list [0]>
# 3 CART_bagged_vl          <tibble [1 × 4]> <opts[0]> <list [0]>
# 4 RF_vl                   <tibble [1 × 4]> <opts[0]> <list [0]>
# 5 boosting_vl             <tibble [1 × 4]> <opts[0]> <list [0]>
# 6 Cubist_vl               <tibble [1 × 4]> <opts[0]> <list [0]>
# 7 SVM_radial_vl           <tibble [1 × 4]> <opts[0]> <list [0]>
# 8 SVM_poly_vl             <tibble [1 × 4]> <opts[0]> <list [0]>
# 9 KNN_vl                  <tibble [1 × 4]> <opts[0]> <list [0]>
#10 neural_network_vl       <tibble [1 × 4]> <opts[1]> <list [0]>
#11 full_quad_linear_reg_vl <tibble [1 × 4]> <opts[0]> <list [0]>
#12 full_quad_KNN_vl        <tibble [1 × 4]> <opts[0]> <list [0]>


## Tuning and evaluating
grid_ctrl <- control_grid(
    save_pred = TRUE,
    parallel_over = "everything",
    save_workflow = TRUE
    )

grid_results_cd <- all_workflows_cd |>
  workflow_map(
    seed = 1505,
    resamples = cd_folds,
    grid = 2,
    control = grid_ctrl
    )
grid_results_cd
## A workflow set/tibble: 12 × 4
#  wflow_id                info             option    result   
#  <chr>                   <list>           <list>    <list>   
# 1 MARS_cd                 <tibble [1 × 4]> <opts[3]> <tune[+]>
# 2 CART_cd                 <tibble [1 × 4]> <opts[3]> <tune[+]>
# 3 CART_bagged_cd          <tibble [1 × 4]> <opts[3]> <rsmp[+]>
# 4 RF_cd                   <tibble [1 × 4]> <opts[3]> <tune[+]>
# 5 boosting_cd             <tibble [1 × 4]> <opts[3]> <tune[+]>
# 6 Cubist_cd               <tibble [1 × 4]> <opts[3]> <tune[+]>
# 7 SVM_radial_cd           <tibble [1 × 4]> <opts[3]> <tune[+]>
# 8 SVM_poly_cd             <tibble [1 × 4]> <opts[3]> <tune[+]>
# 9 KNN_cd                  <tibble [1 × 4]> <opts[3]> <tune[+]>
#10 neural_network_cd       <tibble [1 × 4]> <opts[4]> <tune[+]>
#11 full_quad_linear_reg_cd <tibble [1 × 4]> <opts[3]> <tune[+]>
#12 full_quad_KNN_cd        <tibble [1 × 4]> <opts[3]> <tune[+]>

grid_results_cd |> 
  rank_results() |> 
  filter(.metric == "rmse") |> 
  select(model, .config, rmse = mean, rank)
## A tibble: 23 × 4
#   model         .config                  rmse  rank
#   <chr>         <chr>                   <dbl> <int>
# 1 mars          Preprocessor1_Model2  0.00105     1
# 2 cubist_rules  Preprocessor1_Model2 48.8         2
# 3 cubist_rules  Preprocessor1_Model1 49.6         3
# 4 svm_poly      Preprocessor1_Model1 60.5         4
# 5 bag_tree      Preprocessor1_Model1 61.3         5
# 6 decision_tree Preprocessor1_Model1 64.9         6
# 7 rand_forest   Preprocessor1_Model1 77.0         7
# 8 mlp           Preprocessor1_Model2 86.7         8
# 9 svm_poly      Preprocessor1_Model2 89.6         9
#10 decision_tree Preprocessor1_Model2 93.7        10
## ℹ 13 more rows
## ℹ Use `print(n = ...)` to see more rows

grid_results_cd |> 
  rank_results() |> 
  filter(.metric == "rsq") |> 
  select(model, .config, rsq = mean, rank)
## A tibble: 23 × 4
#   model         .config                rsq  rank
#   <chr>         <chr>                <dbl> <int>
# 1 mars          Preprocessor1_Model2 1         1
# 2 cubist_rules  Preprocessor1_Model2 0.903     2
# 3 cubist_rules  Preprocessor1_Model1 0.906     3
# 4 svm_poly      Preprocessor1_Model1 0.938     4
# 5 bag_tree      Preprocessor1_Model1 0.916     5
# 6 decision_tree Preprocessor1_Model1 0.915     6
# 7 rand_forest   Preprocessor1_Model1 0.856     7
# 8 mlp           Preprocessor1_Model2 0.879     8
# 9 svm_poly      Preprocessor1_Model2 0.912     9
#10 decision_tree Preprocessor1_Model2 0.972    10
## ℹ 13 more rows
## ℹ Use `print(n = ...)` to see more rows

autoplot(
  grid_results_cd,
  rank_metric = "rmse",  # <- how to order models
  metric = "rmse",       # <- which metric to visualize
  select_best = TRUE     # <- one point per workflow
) +
  geom_text(aes(y = mean - 100, label = wflow_id), angle = 90, hjust = 1) +
  lims(y = c(-150, 350)) #+
  #theme(legend.position = "none")

autoplot(
  grid_results_cd,
  rank_metric = "rsq", 
  metric = "rsq",       
  select_best = TRUE     
) +
  geom_text(aes(y = mean - 1/6, label = wflow_id), angle = 90, hjust = 1) +
  lims(y = c(1/2, 1))

autoplot(grid_results_cd, id = "MARS_cd", metric = "rmse")

autoplot(grid_results_cd, id = "MARS_cd", metric = "rsq")

grid_results_vl <- all_workflows_vl |>
  workflow_map(
    seed = 1506,
    resamples = vl_folds,
    grid = 2,
    control = grid_ctrl
    )
grid_results_vl
## A workflow set/tibble: 12 × 4
#   wflow_id                info             option    result   
#   <chr>                   <list>           <list>    <list>   
# 1 MARS_vl                 <tibble [1 × 4]> <opts[3]> <tune[x]>
# 2 CART_vl                 <tibble [1 × 4]> <opts[3]> <tune[x]>
# 3 CART_bagged_vl          <tibble [1 × 4]> <opts[3]> <rsmp[x]>
# 4 RF_vl                   <tibble [1 × 4]> <opts[3]> <tune[x]>
# 5 boosting_vl             <tibble [1 × 4]> <opts[3]> <tune[x]>
# 6 Cubist_vl               <tibble [1 × 4]> <opts[3]> <tune[x]>
# 7 SVM_radial_vl           <tibble [1 × 4]> <opts[3]> <tune[x]>
# 8 SVM_poly_vl             <tibble [1 × 4]> <opts[3]> <tune[x]>
# 9 KNN_vl                  <tibble [1 × 4]> <opts[3]> <tune[x]>
#10 neural_network_vl       <tibble [1 × 4]> <opts[4]> <tune[x]>
#11 full_quad_linear_reg_vl <tibble [1 × 4]> <opts[3]> <tune[x]>
#12 full_quad_KNN_vl        <tibble [1 × 4]> <opts[3]> <tune[x]>


## Racing
library(finetune)
race_ctrl <- control_race(
    save_pred = TRUE,
    parallel_over = "everything",
    save_workflow = TRUE
  )

race_results_cd <- all_workflows_cd |>
  workflow_map(
    "tune_race_anova",
    seed = 1507,
    resamples = cd_folds,
    grid = 2,
    control = race_ctrl
  )
race_results_cd
## A workflow set/tibble: 12 × 4
#   wflow_id                info             option    result        
#   <chr>                   <list>           <list>    <list>        
# 1 MARS_cd                 <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 2 CART_cd                 <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 3 CART_bagged_cd          <tibble [1 × 4]> <opts[3]> <rsmp[+]>     
# 4 RF_cd                   <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 5 boosting_cd             <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 6 Cubist_cd               <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 7 SVM_radial_cd           <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 8 SVM_poly_cd             <tibble [1 × 4]> <opts[3]> <try-errr [1]>
# 9 KNN_cd                  <tibble [1 × 4]> <opts[3]> <try-errr [1]>
#10 neural_network_cd       <tibble [1 × 4]> <opts[4]> <try-errr [1]>
#11 full_quad_linear_reg_cd <tibble [1 × 4]> <opts[3]> <try-errr [1]>
#12 full_quad_KNN_cd        <tibble [1 × 4]> <opts[3]> <try-errr [1]>


## Selection
best_results_cd <- grid_results_cd |> 
  extract_workflow_set_result("MARS_cd") |> 
  select_best(metric = "rmse")
best_results_cd
## A tibble: 1 × 2
#  prod_degree .config             
#        <int> <chr>               
#1           2 Preprocessor1_Model2

MARS_test_results_cd <- grid_results_cd |> 
  extract_workflow("MARS_cd") |> 
  finalize_workflow(best_results_cd) |> 
  last_fit(split = cd_split)

collect_metrics(MARS_test_results_cd)
## A tibble: 2 × 4
#  .metric .estimator .estimate .config             
#  <chr>   <chr>          <dbl> <chr>               
#1 rmse    standard    6.07e-14 Preprocessor1_Model1
#2 rsq     standard    1   e+ 0 Preprocessor1_Model1

MARS_test_results_cd |> 
  collect_predictions() |> 
  ggplot(aes(x = cd_2022, y = .pred)) + 
  geom_abline(color = "gray50", lty = 2) + 
  geom_point() + 
  coord_obs_pred() + 
  labs(x = "observed", y = "predicted")
