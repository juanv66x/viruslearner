test_that("`cd_fit()` works as expected", {
  
  library(Cubist)
  library(kernlab)
  library(kknn)
  library(ranger)
  library(rules)
  data("fens_obj2", package = "viruslearner")
  data("cd_test", package = "viruslearner")
  testdata <- cd_test
  outcome <- "cd_2023"
  predicted <- ".pred"
  expect_snapshot(
    print(
      class(fens_obj2 |>  cd_fit(outcome, testdata, predicted, mode = TRUE, show_members = TRUE))
    )
  )
})

