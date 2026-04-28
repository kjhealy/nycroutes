# Extracted from test-complexes.R:75

# setup ------------------------------------------------------------------------
library(testthat)
test_env <- simulate_test_env(package = "nycroutes", path = "..")
attach(test_env, warn.conflicts = FALSE)

# test -------------------------------------------------------------------------
routes_for <- function(id) {
    sort(nyc_subway_complex_routes_df$route_id[
      nyc_subway_complex_routes_df$station_complex_id == id
    ])
  }
expect_true(all(c("1", "2", "3", "7", "A", "C", "E", "N", "Q", "R", "S", "W")
                  %in% routes_for("611")))
