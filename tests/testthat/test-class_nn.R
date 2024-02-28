test_that("`class_nn` plots as expected", {
  local_edition(3)
  library(nnet)
  library(NeuralNetTools)
  data("mortality", package = "viruslearner")
  vip_featured <- "V23"
  hiv_data <- mortality
  hu <- 16
  plty <- 0.0000639
  epo <- 720
  set.seed(7)
  vdiffr::expect_doppelganger(
    title = "class_nn",
    fig = class_nn(vip_featured, hiv_data, hu, plty, epo),
  )
})




