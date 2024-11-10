test_that("`cd_stack()` plots as expected", {
  
  library(Cubist)
  library(kernlab)
  library(kknn)
  library(ranger)
  library(rules)
  data("fens_obj2", package = "viruslearner")
expect_snapshot(
  print(
    fens_obj2 |> class()
  )
)
})
