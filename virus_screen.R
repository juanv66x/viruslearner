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
# $ cd_2019                <dbl> 826.0037, 171.0233, 343.9983, 425.0167, 442.9945, 509.0036, 561.0104, 175.0028, 766.0277, 78…
# $ vl_2019                <dbl> 42.095592, 11390.034161, 38962.985396, 42.006169, 77.041309, 4096.941839, 104.995359, 11390.…
# $ cd_2021                <dbl> 993.9797, 276.9826, 332.9770, 455.9728, 480.9850, 554.9740, 498.0103, 232.0022, 606.9889, 43…
# $ vl_2021                <dbl> 8.104566e+01, 1.692232e+03, 5.114226e+03, 7.323554e+01, 2.904255e+02, 3.065528e+03, 1.696200…
# $ cd_2022                <dbl> 702.0181, 128.9572, 128.9533, 549.0113, 549.0466, 549.0044, 779.0113, 150.9762, 630.0222, 61…
# $ vl_2022                <dbl> 2.226647e+00, 2.592188e+00, 5.325269e+04, 1.084262e+00, 4.143402e+01, 1.903224e+03, 2.070263…
# $ recovery_rate_2021     <dbl> 0.20335982, 0.61956134, -0.03203875, 0.07283515, 0.08575829, 0.09031447, -0.11229761, 0.3257…
# $ recovery_rate_2022     <dbl> -0.29372990, -0.53442152, -0.61272625, 0.20404403, 0.14150457, -0.01075660, 0.56424742, -0.3…
# $ recovery_rate_2022_2yr <dbl> -0.15010294, -0.24596709, -0.62513402, 0.29174076, 0.23939805, 0.07858639, 0.38858618, -0.13…
# $ viral_rate_2021        <dbl> 9.252767e-01, -8.514287e-01, -8.687414e-01, 7.434472e-01, 2.769737e+00, -2.517522e-01, -9.83…
# $ viral_rate_2022        <dbl> -9.725260e-01, -9.984682e-01, 9.412661e+00, -9.851949e-01, -8.573334e-01, -3.791530e-01, 2.2…
# $ viral_rate_2022_2yr    <dbl> -9.471050e-01, -9.997724e-01, 3.667509e-01, -9.741880e-01, -4.621844e-01, -5.354526e-01, -9.…


## Data spending
cd_split <- initial_split(recovery_rates |> 
                            mutate_at("cd_2022", ~(scale(., center = TRUE, scale = TRUE) |> as.vector()))
                          )
cd_train <- training(cd_split)
cd_test  <- testing(cd_split)
set.seed(1502)
cd_folds <- vfold_cv(cd_train, repeats = 5)

set.seed(1503)
vl_split <- initial_split(recovery_rates |> 
                            mutate(vl_2022 = log10(vl_2022)) |>
                            mutate_at('vl_2022', ~(scale(.) |> as.vector()))
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

simple_vl <- recipe(vl_2022 ~ ., data = vl_train)
poly_vl <- simple_vl |> 
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
   
sim_wfl_vl <- workflow_set(
  preproc = list(simple = simple_vl), 
  models = list(SVM_radial_vl = svm_r_spec, SVM_poly_vl = svm_p_spec, 
                KNN_vl = knn_spec, neural_network_vl = nnet_spec)
  )
sim_wfl_vl
## A workflow set/tibble: 4 × 4
#  wflow_id                 info             option    result    
#  <chr>                    <list>           <list>    <list>    
#1 simple_SVM_radial_vl     <tibble [1 × 4]> <opts[0]> <list [0]>
#2 simple_SVM_poly_vl       <tibble [1 × 4]> <opts[0]> <list [0]>
#3 simple_KNN_vl            <tibble [1 × 4]> <opts[0]> <list [0]>
#4 simple_neural_network_vl <tibble [1 × 4]> <opts[0]> <list [0]>
sim_wfl_vl |> extract_workflow(id = "simple_SVM_poly_vl")
# ══ Workflow ════════════════════════════════════════════════════════════════════════════════════════════════════════════════
# Preprocessor: Recipe
# Model: svm_poly()
# 
# ── Preprocessor ────────────────────────────────────────────────────────────────────────────────────────────────────────────
# 0 Recipe Steps
# 
# ── Model ───────────────────────────────────────────────────────────────────────────────────────────────────────────────────
# Polynomial Support Vector Machine Model Specification (regression)
# 
# Main Arguments:
#   cost = tune()
# degree = tune()
# 
# Computational engine: kernlab 
sim_wfl_vl <- sim_wfl_vl |>
  option_add(param_info = nnet_param, id = "simple_neural_network_vl")
sim_wfl_vl
## A workflow set/tibble: 4 × 4
#  wflow_id                 info             option    result    
#  <chr>                    <list>           <list>    <list>    
#1 simple_SVM_radial_vl     <tibble [1 × 4]> <opts[0]> <list [0]>
#2 simple_SVM_poly_vl       <tibble [1 × 4]> <opts[0]> <list [0]>
#3 simple_KNN_vl            <tibble [1 × 4]> <opts[0]> <list [0]>
#4 simple_neural_network_vl <tibble [1 × 4]> <opts[1]> <list [0]>

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
  preproc = list(simpvar = model_vars_vl), 
  models = list(MARS_vl = mars_spec, CART_vl = cart_spec, 
                CART_bagged_vl = bag_cart_spec, RF_vl = rf_spec, 
                boosting_vl = xgb_spec, Cubist_vl = cubist_spec)
  )
no_pre_proc_vl
## A workflow set/tibble: 6 × 4
#  wflow_id               info             option    result    
#  <chr>                  <list>           <list>    <list>    
#1 simpvar_MARS_vl        <tibble [1 × 4]> <opts[0]> <list [0]>
#2 simpvar_CART_vl        <tibble [1 × 4]> <opts[0]> <list [0]>
#3 simpvar_CART_bagged_vl <tibble [1 × 4]> <opts[0]> <list [0]>
#4 simpvar_RF_vl          <tibble [1 × 4]> <opts[0]> <list [0]>
#5 simpvar_boosting_vl    <tibble [1 × 4]> <opts[0]> <list [0]>
#6 simpvar_Cubist_vl      <tibble [1 × 4]> <opts[0]> <list [0]>

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

all_workflows_vl <- bind_rows(no_pre_proc_vl, sim_wfl_vl, with_features_vl) |> 
  mutate(wflow_id = gsub("(simple_)|(simpvar_)", "", wflow_id))
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
#   model        .config                  rmse  rank
#   <chr>        <chr>                   <dbl> <int>
# 1 mars         Preprocessor1_Model2 0.000154     1
# 2 cubist_rules Preprocessor1_Model2 0.222        2
# 3 mlp          Preprocessor1_Model2 0.232        3
# 4 cubist_rules Preprocessor1_Model1 0.239        4
# 5 mlp          Preprocessor1_Model1 0.360        5
# 6 mars         Preprocessor1_Model1 0.366        6
# 7 svm_poly     Preprocessor1_Model1 0.457        7
# 8 rand_forest  Preprocessor1_Model1 0.487        8
# 9 bag_tree     Preprocessor1_Model1 0.512        9
#10 rand_forest  Preprocessor1_Model2 0.616       10
## ℹ 13 more rows
## ℹ Use `print(n = ...)` to see more rows

grid_results_cd |> 
  rank_results() |> 
  filter(.metric == "rsq") |> 
  select(model, .config, rsq = mean, rank)
## A tibble: 23 × 4
#   model        .config                rsq  rank
#   <chr>        <chr>                <dbl> <int>
# 1 mars         Preprocessor1_Model2 1.00      1
# 2 cubist_rules Preprocessor1_Model2 0.943     2
# 3 mlp          Preprocessor1_Model2 0.981     3
# 4 cubist_rules Preprocessor1_Model1 0.950     4
# 5 mlp          Preprocessor1_Model1 0.930     5
# 6 mars         Preprocessor1_Model1 0.930     6
# 7 svm_poly     Preprocessor1_Model1 0.935     7
# 8 rand_forest  Preprocessor1_Model1 0.914     8
# 9 bag_tree     Preprocessor1_Model1 0.889     9
#10 rand_forest  Preprocessor1_Model2 0.891    10
## ℹ 13 more rows
## ℹ Use `print(n = ...)` to see more rows

autoplot(
  grid_results_cd,
  rank_metric = "rmse",  # <- how to order models
  metric = "rmse",       # <- which metric to visualize
  select_best = TRUE     # <- one point per workflow
  ) +
  geom_text(aes(y = mean - 1, label = wflow_id), angle = 90, hjust = 1) +
  lims(y = c(-2, 5/2)) #+
  #theme(legend.position = "none")

autoplot(
  grid_results_cd,
  rank_metric = "rsq", 
  metric = "rsq",       
  select_best = TRUE     
  ) +
  geom_text(aes(y = mean - 1/6, label = wflow_id), angle = 90, hjust = 1) +
  lims(y = c(4/10, 1))

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

grid_results_vl |> 
  rank_results() |> 
  filter(.metric == "rmse") |> 
  select(model, .config, rmse = mean, rank)
## A tibble: 23 × 4
#   model            .config               rmse  rank
#   <chr>            <chr>                <dbl> <int>
# 1 cubist_rules     Preprocessor1_Model1 0.528     1
# 2 cubist_rules     Preprocessor1_Model2 0.583     2
# 3 bag_tree         Preprocessor1_Model1 0.607     3
# 4 decision_tree    Preprocessor1_Model1 0.627     4
# 5 rand_forest      Preprocessor1_Model2 0.627     5
# 6 decision_tree    Preprocessor1_Model2 0.649     6
# 7 nearest_neighbor Preprocessor1_Model2 0.768     7
# 8 nearest_neighbor Preprocessor1_Model2 0.870     8
# 9 nearest_neighbor Preprocessor1_Model1 0.886     9
#10 nearest_neighbor Preprocessor1_Model1 0.887    10
## ℹ 13 more rows
## ℹ Use `print(n = ...)` to see more rows

grid_results_vl |> 
  rank_results() |> 
  filter(.metric == "rsq") |> 
  select(model, .config, rmse = mean, rank)
## A tibble: 23 × 4
#   model            .config               rmse  rank
#   <chr>            <chr>                <dbl> <int>
# 1 cubist_rules     Preprocessor1_Model1 0.878     1
# 2 cubist_rules     Preprocessor1_Model2 0.877     2
# 3 bag_tree         Preprocessor1_Model1 0.887     3
# 4 decision_tree    Preprocessor1_Model1 0.864     4
# 5 rand_forest      Preprocessor1_Model2 0.838     5
# 6 decision_tree    Preprocessor1_Model2 0.863     6
# 7 nearest_neighbor Preprocessor1_Model2 0.746     7
# 8 nearest_neighbor Preprocessor1_Model2 0.689     8
# 9 nearest_neighbor Preprocessor1_Model1 0.779     9
#10 nearest_neighbor Preprocessor1_Model1 0.723    10
## ℹ 13 more rows
## ℹ Use `print(n = ...)` to see more rows

autoplot(
  grid_results_vl,
  rank_metric = "rmse",  
  metric = "rmse",       
  select_best = TRUE  
  ) 

autoplot(
  grid_results_vl,
  rank_metric = "rsq", 
  metric = "rsq",       
  select_best = TRUE     
) +
  geom_text(aes(y = mean - 1/6, label = wflow_id), angle = 90, hjust = 1) +
  lims(y = c(4/10, 1))

autoplot(grid_results_vl, id = "MARS_vl", metric = "rmse")

autoplot(grid_results_vl, id = "MARS_vl", metric = "rsq")


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

race_results_vl <- all_workflows_vl |>
  workflow_map(
    "tune_race_anova",
    seed = 1508,
    resamples = cd_folds,
    grid = 20,
    control = race_ctrl
  )


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
#1 rmse    standard    2.10e-16 Preprocessor1_Model1
#2 rsq     standard    1   e+ 0 Preprocessor1_Model1

MARS_test_results_cd |> 
  collect_predictions() |> 
  ggplot(aes(x = cd_2022, y = .pred)) + 
  geom_abline(color = "gray50", lty = 2) + 
  geom_point() + 
  coord_obs_pred() + 
  labs(x = "observed", y = "predicted")

best_results_vl <- grid_results_vl |> 
  extract_workflow_set_result("Cubist_vl") |> 
  select_best(metric = "rmse")
best_results_vl
## A tibble: 1 × 3
#  committees neighbors .config             
#       <int>     <int> <chr>               
#1         34         6 Preprocessor1_Model1

Cubist_test_results_vl <- grid_results_vl |> 
  extract_workflow("Cubist_vl") |> 
  finalize_workflow(best_results_vl) |> 
  last_fit(split = vl_split)

collect_metrics(Cubist_test_results_vl)
## A tibble: 2 × 4
#  .metric .estimator .estimate .config             
#  <chr>   <chr>          <dbl> <chr>               
#1 rmse    standard       0.675 Preprocessor1_Model1
#2 rsq     standard       0.636 Preprocessor1_Model1

Cubist_test_results_vl |> 
  collect_predictions() |> 
  ggplot(aes(x = vl_2022, y = .pred)) + 
  geom_abline(color = "gray50", lty = 2) + 
  geom_point() + 
  coord_obs_pred() + 
  labs(x = "observed", y = "predicted")

