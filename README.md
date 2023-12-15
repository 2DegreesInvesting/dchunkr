
<!-- README.md is generated from README.Rmd. Please edit that file -->

# dchunkr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/2DegreesInvesting/dchunkr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/2DegreesInvesting/dchunkr/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of dchunkr is provide basic tools for computing on data bigger
than you can fit in memory. Use it to chunk your data, run multiple
chunks in parallel, and cache the result of each chunk. This allows you
to use your computer resources more efficiently, and to resume after
interruptions. It’s designed to be a minimal and to play well with the
tidyverse and friends. For a mature, complete alternative see the
wonderful [targets](https://docs.ropensci.org/targets/) package.

## Installation

You can install the development version of dchunkr from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("2DegreesInvesting/dchunkr")
```

## Example

``` r
library(dplyr, warn.conflicts = FALSE)
library(readr)
library(future)
library(furrr)
library(fs)
library(dchunkr)

set.seed(123)

# You may complete the job faster if multiple computers run the same code and
# feed the same cache but work in different, random chunks of data.
shuffle <- function(data) slice_sample(data, n = nrow(data))

# Enable computing over multiple workers in parallel
plan(multisession)

data <- tibble(id = c(1, 1, 1, 2, 3))

job <- data |>
  # Each chunk can run parallel to other chunks
  nest_chunk(.by = "id", chunks = 3) |>
  # Set where to cache the result of each chunk
  add_file(parent = cache_path("demo"), ext = ".csv") |>
  # Don't recompute what's already cached, so you can resume after interruptions
  pick_undone()
job
#> # A tibble: 3 × 4
#>   chunk data             file                        done 
#>   <int> <list>           <fs::path>                  <lgl>
#> 1     1 <tibble [3 × 1]> ~/.cache/dchunkr/demo/1.csv FALSE
#> 2     2 <tibble [1 × 1]> ~/.cache/dchunkr/demo/2.csv FALSE
#> 3     3 <tibble [1 × 1]> ~/.cache/dchunkr/demo/3.csv FALSE

# Here is the important function you want to run for each chunk of data
important <- function(data) mutate(data, x2 = id * 2)

job |>
  shuffle() |> 
  # Select the columns that match the signature of the function passed to pmap
  select(data, file) |>
  # Map your important fuction to each chunk and write the result to the cache
  future_pwalk(\(data, file) important(data) |> write_csv(file))

# See cached files
dir_tree(cache_path("demo"))
#> ~/.cache/dchunkr/demo
#> ├── 1.csv
#> ├── 2.csv
#> └── 3.csv

# Read all cached files at once
read_csv(dir_ls(cache_path("demo")))
#> Rows: 5 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> dbl (2): id, x2
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 5 × 2
#>      id    x2
#>   <dbl> <dbl>
#> 1     1     2
#> 2     1     2
#> 3     1     2
#> 4     2     4
#> 5     3     6

# Cleanup before the next run
cache_path("demo") |> dir_delete()
```
