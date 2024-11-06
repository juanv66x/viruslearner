test_that("`cd_fit()` works as expected", {
  
  library(baguette)
  library(Cubist)
  library(rules)
  data("cd_obj1", package = "viruslearner")
  data("cd_test", package = "viruslearner")
  testdata <- cd_test
  outcome <- "cd_2023"
  predicted <- ".pred"
  expect_snapshot(
    print(
      class(cd_obj1 |> cd_fit(outcome, testdata, predicted, TRUE))
    )
  )
})
