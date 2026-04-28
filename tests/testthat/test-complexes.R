test_that("nyc_subway_stop_routes_df is unique on (stop_id, route_id)", {
  expect_equal(
    anyDuplicated(nyc_subway_stop_routes_df[, c("stop_id", "route_id")]),
    0L
  )
  expect_true(all(!is.na(nyc_subway_stop_routes_df$stop_id)))
  expect_true(all(!is.na(nyc_subway_stop_routes_df$route_id)))
})

test_that("nyc_subway_complexes_df is unique on station_complex_id", {
  expect_equal(
    anyDuplicated(nyc_subway_complexes_df$station_complex_id),
    0L
  )
  expect_true(all(nyc_subway_complexes_df$n_stops >= 1L))
})

test_that("nyc_subway_complex_stops_df is unique on (station_complex_id, stop_id)", {
  expect_equal(
    anyDuplicated(
      nyc_subway_complex_stops_df[, c("station_complex_id", "stop_id")]
    ),
    0L
  )
})

test_that("nyc_subway_complex_routes_df is unique on (station_complex_id, route_id)", {
  expect_equal(
    anyDuplicated(
      nyc_subway_complex_routes_df[, c("station_complex_id", "route_id")]
    ),
    0L
  )
})

test_that("complex_stops references parent stops in nyc_subway_stops_parent_sf", {
  parents <- nyc_subway_stops_parent_sf$stop_id
  expect_true(all(nyc_subway_complex_stops_df$stop_id %in% parents))
})

test_that("complex_stops references complexes in nyc_subway_complexes_df", {
  expect_setequal(
    nyc_subway_complex_stops_df$station_complex_id,
    nyc_subway_complexes_df$station_complex_id
  )
})

test_that("n_stops in complexes_df equals row count in complex_stops_df", {
  recount <- as.data.frame(
    table(nyc_subway_complex_stops_df$station_complex_id)
  )
  names(recount) <- c("station_complex_id", "n_stops_recounted")
  recount$station_complex_id <- as.character(recount$station_complex_id)
  joined <- merge(
    nyc_subway_complexes_df[, c("station_complex_id", "n_stops")],
    recount,
    by = "station_complex_id"
  )
  expect_equal(joined$n_stops, joined$n_stops_recounted)
})

test_that("every complex has at least one route", {
  with_routes <- unique(nyc_subway_complex_routes_df$station_complex_id)
  expect_setequal(with_routes, nyc_subway_complexes_df$station_complex_id)
})

test_that("known complexes carry the expected routes", {
  routes_for <- function(id) {
    sort(nyc_subway_complex_routes_df$route_id[
      nyc_subway_complex_routes_df$station_complex_id == id
    ])
  }

  expect_true(all(c("1", "2", "3", "7", "A", "C", "E", "GS", "N", "Q", "R", "W")
                  %in% routes_for("611")))
  expect_true(all(c("4", "5", "6", "7", "GS") %in% routes_for("610")))
  expect_true(all(c("4", "5", "6", "L", "N", "Q", "R", "W") %in% routes_for("602")))
  expect_setequal(routes_for("447"), c("7", "7X"))
})

test_that("constituent parent stops of a complex are not far apart", {
  skip_if_not_installed("sf")

  parents_2263 <- sf::st_transform(nyc_subway_stops_parent_sf, 2263)
  coords <- cbind(
    stop_id = parents_2263$stop_id,
    as.data.frame(sf::st_coordinates(parents_2263))
  )
  members <- merge(nyc_subway_complex_stops_df, coords, by = "stop_id")
  multi <- split(members, members$station_complex_id)
  multi <- multi[vapply(multi, nrow, integer(1)) > 1]

  max_dists <- vapply(
    multi,
    function(cm) max(dist(as.matrix(cm[, c("X", "Y")]))),
    numeric(1)
  )
  expect_lt(max(max_dists), 2500)
})
