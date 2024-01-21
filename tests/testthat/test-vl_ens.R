test_that("vl_ens()` works as expected", {
  local_edition(3)
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
  outcome <- "vl_2023"
  traindata <- vl_train
  viralvars <- c("vl_2019", "vl_2021", "vl_2022")
  logbase <- 10
  seed <- 1502
  repetitions <- 2
  gridsize <- 1
  expect_snapshot(
    print(
      vl_ens(outcome, traindata, viralvars, logbase, seed, repetitions, gridsize)
    )
  )
}
)