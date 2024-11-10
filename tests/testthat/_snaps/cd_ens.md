# `cd_ens()` works as expected

    Code
      print(cd_ens(get_models = TRUE))
    Output
      $regression_models
      $regression_models$rf
      Random Forest Model Specification (regression)
      
      Main Arguments:
        mtry = hardhat::tune()
        trees = hardhat::tune()
        min_n = hardhat::tune()
      
      Computational engine: ranger 
      
      
      $regression_models$Cubist
    Message
      ! parsnip could not locate an implementation for `cubist_rules` model specifications using the `Cubist` engine.
      i The parsnip extension package rules implements support for this specification.
      i Please install (if needed) and load to continue.
    Output
      Cubist Model Specification (regression)
      
      Main Arguments:
        committees = hardhat::tune()
        neighbors = hardhat::tune()
      
      Computational engine: Cubist 
      
      
      $regression_models$SVM_radial
      Radial Basis Function Support Vector Machine Model Specification (regression)
      
      Main Arguments:
        cost = hardhat::tune()
        rbf_sigma = hardhat::tune()
      
      Computational engine: kernlab 
      
      
      $regression_models$SVM_poly
      Polynomial Support Vector Machine Model Specification (regression)
      
      Main Arguments:
        cost = hardhat::tune()
        degree = hardhat::tune()
      
      Computational engine: kernlab 
      
      
      $regression_models$KNN
      K-Nearest Neighbor Model Specification (regression)
      
      Main Arguments:
        neighbors = hardhat::tune()
        weight_func = hardhat::tune()
        dist_power = hardhat::tune()
      
      Computational engine: kknn 
      
      
      $regression_models$neural_network
      Single Layer Neural Network Model Specification (regression)
      
      Main Arguments:
        hidden_units = hardhat::tune()
        penalty = hardhat::tune()
        epochs = hardhat::tune()
      
      Engine-Specific Arguments:
        MaxNWts = 2600
      
      Computational engine: nnet 
      
      
      
      $classification_models
      $classification_models$SVM_radial
      Radial Basis Function Support Vector Machine Model Specification (classification)
      
      Main Arguments:
        cost = hardhat::tune()
        rbf_sigma = hardhat::tune()
      
      Computational engine: kernlab 
      
      
      $classification_models$SVM_poly
      Polynomial Support Vector Machine Model Specification (classification)
      
      Main Arguments:
        cost = hardhat::tune()
        degree = hardhat::tune()
      
      Computational engine: kernlab 
      
      
      $classification_models$KNN
      K-Nearest Neighbor Model Specification (classification)
      
      Main Arguments:
        neighbors = hardhat::tune()
        weight_func = hardhat::tune()
        dist_power = hardhat::tune()
      
      Computational engine: kknn 
      
      
      $classification_models$neural_network
      Single Layer Neural Network Model Specification (classification)
      
      Main Arguments:
        hidden_units = hardhat::tune()
        penalty = hardhat::tune()
        epochs = hardhat::tune()
      
      Engine-Specific Arguments:
        MaxNWts = 2600
      
      Computational engine: nnet 
      
      
      

