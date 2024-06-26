% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{obj_mod3}
\alias{obj_mod3}
\title{A stacked ensemble model of abs data}
\format{
A data frame with the following columns:
\describe{
\item{member}{Character vector, names of ensemble members}
\item{type}{Character vector, types of ensemble members}
\item{weight}{Numeric vector, weights of ensemble members}
}
}
\usage{
obj_mod3
}
\description{
This object represents a stacked ensemble model that retains 2 out of 4 possible candidate members.
It has a penalty of 0.0206913808111479 and a mixture of 1.
}
\details{
The 2 highest weighted members are:
\itemize{
\item \code{cate_SVM_poly_1_1}: Type - svm_poly, Weight - 4.85
\item \code{cate_KNN_1_1 }: Type - nearest_neighbor, Weight - 1.50
}

Members have not yet been fitted with \code{fit_members()}.
}
\examples{
\donttest{
  # Load the object
  data("obj_mod3", package = "viruslearner")
  # Print the dataset
  print(obj_mod3)
}
}
\keyword{datasets}
