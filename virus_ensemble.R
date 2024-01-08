library(tidymodels)
library(stacks)
library(rules)
library(baguette)
library(xgboost)
library(kknn)
library(glmnet)
tidymodels_prefer()

cd_stack <- stacks() |> 
  add_candidates(grid_results_cd)

cd_stack
# A data stack with 12 model definitions and 23 candidate members:
#   MARS_cd: 2 model configurations
#   CART_cd: 2 model configurations
#   CART_bagged_cd: 1 model configuration
#   RF_cd: 2 model configurations
#   boosting_cd: 2 model configurations
#   Cubist_cd: 2 model configurations
#   SVM_radial_cd: 2 model configurations
#   SVM_poly_cd: 2 model configurations
#   KNN_cd: 2 model configurations
#   neural_network_cd: 2 model configurations
#   full_quad_linear_reg_cd: 2 model configurations
#   full_quad_KNN_cd: 2 model configurations
# Outcome: cd_2022 (numeric)

vl_stack <- stacks() |> 
  add_candidates(grid_results_vl)

vl_stack
# A data stack with 12 model definitions and 23 candidate members:
#   MARS_vl: 2 model configurations
#   CART_vl: 2 model configurations
#   CART_bagged_vl: 1 model configuration
#   RF_vl: 2 model configurations
#   boosting_vl: 2 model configurations
#   Cubist_vl: 2 model configurations
#   SVM_radial_vl: 2 model configurations
#   SVM_poly_vl: 2 model configurations
#   KNN_vl: 2 model configurations
#   neural_network_vl: 2 model configurations
#   full_quad_linear_reg_vl: 2 model configurations
#   full_quad_KNN_vl: 2 model configurations
# Outcome: vl_2022 (numeric)

set.seed(2001)
ens_cd <- blend_predictions(cd_stack)

autoplot(ens_cd)

set.seed(2002)
ens_vl <- blend_predictions(vl_stack)

autoplot(ens_vl)

set.seed(2003)
ens_cd <- blend_predictions(cd_stack, penalty = 10^seq(-2, -0.5, length = 20))

autoplot(ens_cd)

set.seed(2004)
ens_vl <- blend_predictions(vl_stack, penalty = 10^seq(-2, -0.5, length = 20))

autoplot(ens_vl)

ens_cd
# ── A stacked ensemble model ─────────────────────────────────────
# 
# Out of 23 possible candidate members, the ensemble retained 7.
# Penalty: 0.01.
# Mixture: 1.
# 
# The 7 highest weighted members are:
# # A tibble: 7 × 3
#   member                      type           weight
#   <chr>                       <chr>           <dbl>
# 1 MARS_cd_1_2                 mars          0.803  
# 2 SVM_poly_cd_1_1             svm_poly      0.0506 
# 3 neural_network_cd_1_1       mlp           0.0427 
# 4 full_quad_linear_reg_cd_1_2 linear_reg    0.0377 
# 5 neural_network_cd_1_2       mlp           0.0348 
# 6 CART_cd_1_1                 decision_tree 0.0201 
# 7 MARS_cd_1_1                 mars          0.00795
# 
# Members have not yet been fitted with `fit_members()`.

autoplot(ens_cd, "weights") +
  geom_text(aes(x = weight + 0.01, label = model), hjust = 0) + 
  theme(legend.position = "none") 

res_cd <- stacks:::top_coefs(ens_cd)
all_cd_members <- tibble(
    member = unname(unlist(ens_cd$cols_map)), 
    obj = rep(names(ens_cd$cols_map), map_int(ens_cd$cols_map, length))
  ) |> 
  inner_join(res_cd, by = "member") |> 
  arrange(type, member)
glmn_int_cd <- 
  tidy(ens_cd$coefs) |> 
  filter(term == "(Intercept)") |> 
  mutate(estimate = format(estimate, digits = 2))
config_label_cd <- function(x) {
  x <- dplyr::arrange(x, member)
  x$type <- gsub("_", " ", x$type)
  if (length(unique(x$member)) == 1) {
    x$config <- paste(x$type, "prediction")
  } else {
    congif_chr <- paste0("prediction (config ", 1:nrow(x), ")")
    x$config <- paste(x$type, congif_chr)
  }
  x$weight <- format(x$weight, digits = 2, scientific = FALSE)
  x$term <- paste0(x$weight, " \\times \\text{", x$config, "} \\notag")
  select(x, term, weight)
}
tmp_cd <- 
  all_cd_members |> 
  group_nest(obj, keep = TRUE) |> 
  mutate(data = map(data, ~ config_label_cd(.x))) |> 
  unnest(cols = "data") |> 
  arrange(desc(weight))
eqn_cd <- paste(c(glmn_int_cd$estimate, tmp_cd$term), collapse = " \\\\\n\t+&")
eqn_cd <- paste0("\n\\begin{align}\n \\text{ensemble prediction} &=", eqn_cd, "\n\\end{align}\n")
cat(eqn_cd)

ens_cd <- fit_members(ens_cd)

reg_metrics_cd <- metric_set(rmse, rsq)
ens_test_pred_cd <- predict(ens_cd, cd_test) |> 
  bind_cols(cd_test)

ens_test_pred_cd |> reg_metrics_cd(cd_2022, .pred)

ens_vl
# ── A stacked ensemble model ─────────────────────────────────────
# 
# Out of 23 possible candidate members, the ensemble retained 1.
# Penalty: 0.316227766016838.
# Mixture: 1.
# 
# The 1 highest weighted members are:
# # A tibble: 1 × 3
#   member        type         weight
#   <chr>         <chr>         <dbl>
# 1 Cubist_vl_1_1 cubist_rules  0.607
# 
# Members have not yet been fitted with `fit_members()`.

autoplot(ens_vl, "weights") +
  geom_text(aes(x = weight + 0.01, label = model), hjust = 0) + 
  theme(legend.position = "none") 

res_vl <- stacks:::top_coefs(ens_vl)
all_vl_members <- tibble(
  member = unname(unlist(ens_vl$cols_map)), 
  obj = rep(names(ens_vl$cols_map), map_int(ens_vl$cols_map, length))
) |> 
  inner_join(res_vl, by = "member") |> 
  arrange(type, member)
glmn_int_vl <- tidy(ens_vl$coefs) |> 
  filter(term == "(Intercept)") |> 
  mutate(estimate = format(estimate, digits = 2))
config_label_vl <- function(x) {
  x <- dplyr::arrange(x, member)
  x$type <- gsub("_", " ", x$type)
  if (length(unique(x$member)) == 1) {
    x$config <- paste(x$type, "prediction")
  } else {
    congif_chr <- paste0("prediction (config ", 1:nrow(x), ")")
    x$config <- paste(x$type, congif_chr)
  }
  x$weight <- format(x$weight, digits = 2, scientific = FALSE)
  x$term <- paste0(x$weight, " \\times \\text{", x$config, "} \\notag")
  select(x, term, weight)
}
tmp_vl <- all_vl_members |> 
  group_nest(obj, keep = TRUE) |> 
  mutate(data = map(data, ~ config_label_vl(.x))) |> 
  unnest(cols = "data") |> 
  arrange(desc(weight))
eqn_vl <- paste(c(glmn_int_vl$estimate, tmp_vl$term), collapse = " \\\\\n\t+&")
eqn_vl <- paste0("\n\\begin{align}\n \\text{ensemble prediction} &=", eqn_vl, "\n\\end{align}\n")
cat(eqn_vl)

ens_vl <- fit_members(ens_vl)

reg_metrics_vl <- metric_set(rmse, rsq)
ens_test_pred_vl <- 
  predict(ens_vl, vl_test) |> 
  bind_cols(vl_test)

ens_test_pred_vl |> 
  reg_metrics_cd(vl_2022, .pred)

