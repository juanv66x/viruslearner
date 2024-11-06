#' Plot Weighted Stacked Model
#' 
#' Generates a weighted stacked bar chart using the \code{autoplot} function 
#' from the \code{stacks} package and adds text labels using \code{geom_text} 
#' from \code{ggplot2}.
#'
#' @param obj_mod1 A stacked ensemble model.
#' 
#' @return A weighted stacked bar chart with text labels.
#' @export
#'
#' @examples
#' \donttest{
#' library(baguette)
#' library(kernlab)
#' library(kknn)
#' library(ranger)
#' library(rules)
#' data("cd_obj1", package = "viruslearner")
#' cd_obj1 |> cd_stack()
#' }
cd_stack <- function(obj_mod1) {
  obj_mod1 |>
    stacks::autoplot("weights")  
}