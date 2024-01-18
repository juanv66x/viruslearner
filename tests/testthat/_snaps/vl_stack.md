# `vl_stack()` works as expected

    Code
      print(vl_stack(outcome, traindata, viralvars, logbase, seed, repetitions,
        gridsize))
    Message
      i Creating pre-processing data to finalize unknown parameter: mtry
    Output
      # A data stack with 9 model definitions and 9 candidate members:
      #   simple_rand_forest: 1 model configuration
      #   simple_CART_bagged_cd: 1 model configuration
      #   simple_Cubist_cd: 1 model configuration
      #   normalized_SVM_radial_cd: 1 model configuration
      #   normalized_SVM_poly_cd: 1 model configuration
      #   normalized_KNN_cd: 1 model configuration
      #   normalized_neural_network_cd: 1 model configuration
      #   full_quad_linear_reg_cd: 1 model configuration
      #   full_quad_KNN_cd: 1 model configuration
      # Outcome: vl_2023 (numeric)

