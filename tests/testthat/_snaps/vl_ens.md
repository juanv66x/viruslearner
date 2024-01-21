# vl_ens()` works as expected

    Code
      print(vl_ens(outcome, traindata, viralvars, logbase, seed, repetitions,
        gridsize))
    Message
      i Creating pre-processing data to finalize unknown parameter: mtry
      -- A stacked ensemble model -------------------------------------
      
      Out of 9 possible candidate members, the ensemble retained 4.
      Penalty: 0.0297635144163132.
      Mixture: 1.
      
      The 4 highest weighted members are:
    Output
      # A tibble: 4 x 3
        member                           type         weight
        <chr>                            <chr>         <dbl>
      1 simple_Cubist_cd_1_1             cubist_rules 0.993 
      2 normalized_neural_network_cd_1_1 mlp          0.128 
      3 full_quad_linear_reg_cd_1_1      linear_reg   0.0853
      4 simple_rand_forest_1_1           rand_forest  0.0428
    Message
      
      Members have not yet been fitted with `fit_members()`.

