# `cd_fit()` works as expected

    Code
      print(class(cd_fit(cd_obj1, outcome, testdata, predicted, TRUE, show_members = TRUE)))
    Message
      
      Attaching package: 'purrr'
      
      The following object is masked from 'package:kernlab':
      
          cross
      
      The following object is masked from 'package:testthat':
      
          is_null
      
    Output
      [1] "linear_stack" "model_stack"  "list"        

