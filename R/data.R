#' A stacked ensemble model of CD4 data
#'
#' This object represents a stacked ensemble model that retains 5 out of 54 possible candidate members.
#' It has a penalty of 0.0885866790410082 and a mixture of 1.
#'
#' The 2 highest weighted members are:
#' \itemize{
#'   \item \code{simple_Cubist_1_1}: Type - cubist_rules, Weight - 0.596 
#'   \item \code{normalized_neural_network_1_7}: Type - mlp, Weight - 0.222
#' }
#'
#' Members have not yet been fitted with \code{fit_members()}.
#' 
#' @format A data frame with the following columns:
#'   \describe{
#'     \item{member}{Character vector, names of ensemble members}
#'     \item{type}{Character vector, types of ensemble members}
#'     \item{weight}{Numeric vector, weights of ensemble members}
#'   }
#' @examples
#' \donttest{
#'   # Load the object
#'   data("fens_obj2", package = "viruslearner")
#'   # Print the dataset
#'   print(fens_obj2)
#' }
"fens_obj2"