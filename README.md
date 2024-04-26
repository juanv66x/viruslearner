
<!-- README.md is generated from README.Rmd. Please edit that file -->

# viruslearner

<!-- badges: start -->
<!-- badges: end -->

The goal of viruslearner is to leverage Ensemble Learning techniques for
HIV-Related Metrics.

## Installation

You can install the development version of viruslearner from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("juanv66x/viruslearner")
#> Using github PAT from envvar GITHUB_PAT. Use `gitcreds::gitcreds_set()` and unset GITHUB_PAT in .Renviron (or elsewhere) if you want to use the more secure git credential store instead.
#> Downloading GitHub repo juanv66x/viruslearner@HEAD
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#>      checking for file ‘/tmp/RtmpyIotet/remotes3c6816316d5d/juanv66x-viruslearner-57a96c7/DESCRIPTION’ ...  ✔  checking for file ‘/tmp/RtmpyIotet/remotes3c6816316d5d/juanv66x-viruslearner-57a96c7/DESCRIPTION’ (347ms)
#>   ─  preparing ‘viruslearner’:
#>      checking DESCRIPTION meta-information ...  ✔  checking DESCRIPTION meta-information
#> ─  checking for LF line-endings in source and make files and shell scripts
#> ─  checking for empty or unneeded directories
#> ─  building ‘viruslearner_0.0.0.9000.tar.gz’
#>      
#> 
#> Installing package into '/home/jp/R/x86_64-pc-linux-gnu-library/4.3'
#> (as 'lib' is unspecified)
```

## Example

This is a basic example which shows you how to solve a common problem in
modelling CD4 lynphocites and viral load related data.

``` r
library(viruslearner)
## basic example code
```

You can explore the package built-in data sets.

``` r
data(viral_new)
```
