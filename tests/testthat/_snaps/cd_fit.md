# `cd_fit()` works as expected

    Code
      print(class(cd_fit(obj_mod1, outcome, testdata, predicted, TRUE)))
    Message
      
      Attaching package: 'purrr'
      
      The following object is masked from 'package:kernlab':
      
          cross
      
      The following object is masked from 'package:scales':
      
          discard
      
      The following object is masked from 'package:testthat':
      
          is_null
      
    Output
      [1] "tbl_df"     "tbl"        "data.frame"

