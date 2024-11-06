test_that("`cd_fit()` works as expected", {
  
  if(requireNamespace("baguette"))
  if(requireNamespace("Cubist"))
  if(requireNamespace("rules"))
  data("cd_obj1", package = "viruslearner")
  data("cd_test", package = "viruslearner")
  testdata <- cd_test
  outcome <- "cd_2023"
  predicted <- ".pred"
  expect_snapshot(
    print(
      class(cd_obj1 |> cd_fit(outcome, testdata, predicted, TRUE, show_members = TRUE))
    )
  )
})
