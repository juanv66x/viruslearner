test_that("`cd_fit()` works as expected", {
  library(baguette)
  library(dials)
  library(dplyr)
  library(hardhat)
  library(kernlab)
  library(kknn)
  library(parsnip)
  library(ranger)
  library(recipes)
  library(rsample)
  library(rules)
  library(stacks)
  library(stats)
  library(tidyselect)
  library(tune)
  library(workflows)
  library(workflowsets)
  library(yardstick)
  library(viruslearner)
  data("obj_mod1", package = "viruslearner")
  data("obj_mod1", package = "viruslearner")
  data("cd_test", package = "viruslearner")
  testdata <- cd_test
  outcome <- "cd_2023"
  predicted <- ".pred"
  expect_snapshot(
    print(
      class(obj_mod1 |> cd_fit(outcome, testdata, predicted, TRUE))
    )
  )
})