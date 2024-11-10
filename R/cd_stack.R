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
#' library(Cubist)
#' library(kernlab)
#' library(kknn)
#' library(ranger)
#' library(rules)
#' data("fens_obj2", package = "viruslearner")
#' fens_obj2 |> cd_stack()
#' }
cd_stack <- function(obj_mod1) {
  obj_mod1 |>
    stacks::autoplot("weights")  
}