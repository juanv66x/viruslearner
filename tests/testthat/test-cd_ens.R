test_that("`cd_ens()` works as expected", {
  expect_snapshot(
  print(
    cd_ens(get_models = TRUE) 
  )
)
})