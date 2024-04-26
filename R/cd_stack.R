#' Plot Weighted Stacked Model
#' 
#' Generates a weighted stacked bar chart using the \code{autoplot} function from the \code{stacks} package and adds text labels using \code{geom_text} from \code{ggplot2}.
#'
#' @param obj_mod1 A stacked ensemble model.
#' 
#' @return A weighted stacked bar chart with text labels.
#' @export
#'
#' @examples
#' \donttest{
#' if (!requireNamespace("baguette", quietly = TRUE)) {
#' install.packages("baguette")
#' }
#' library(baguette)
#' library(kernlab)
#' library(kknn)
#' library(ranger)
#' library(rules)
#' library(viruslearner)
#' data("obj_mod1", package = "viruslearner")
#' obj_mod1 |> cd_stack()
#' }
cd_stack <- function(obj_mod1) {
  obj_mod1 |>
    stacks::autoplot("weights")  
  }