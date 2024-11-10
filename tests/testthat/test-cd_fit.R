test_that("`cd_fit()` works as expected", {
  
  library(Cubist)
  library(kernlab)
  library(kknn)
  library(ranger)
  library(rules)
  data("fens_obj2", package = "viruslearner")
  expect_snapshot(
    print(
      class(fens_obj2 |> cd_fit(show_members = TRUE))
    )
  )
})

