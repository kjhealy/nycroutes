## NYC subway routes, stops, transfers, and offset versions
##
## Source: MTA GTFS feed (gtfs_subway.zip)

source(here::here("data-raw", "_source.R"))

rawpath <- here("data-raw", "subway")

subway_gtfs <- read_gtfs(here(rawpath, "gtfs_subway.zip"))
subway_sf <- gtfs_as_sf(subway_gtfs)

# ---- nyc_subway_routes_df -------------------------------------------------
# Route groups table we will join to the subway routes and stops objects.
# The route group is simpler than the route_id, e.g. aggregating all shuttles
# to the "S" route group.
route_groups_df <- read_csv(here("data-raw", "subway", "route_groups.csv"))

# Tabular route metadata (29 named subway services).

nyc_subway_routes_df <- subway_gtfs$routes |>
  as_tibble() |>
  clean_names() |>
  mutate(
    route_color = if_else(
      is.na(route_color) | route_color == "",
      NA_character_,
      paste0("#", route_color)
    ),
    route_text_color = if_else(
      is.na(route_text_color) | route_text_color == "",
      NA_character_,
      paste0("#", route_text_color)
    )
  ) |>
  left_join(route_groups_df, by = join_by(route_id)) |>
  relocate(route_group, .after = route_id)

usethis::use_data(nyc_subway_routes_df, overwrite = TRUE, compress = "xz")

# ---- nyc_subway_routes_sf -------------------------------------------------
# Route linestrings (one per shape_id) joined to route_id, short name, color.

nyc_subway_routes_sf <- subway_sf$shapes |>
  left_join(
    subway_sf$trips |>
      distinct(shape_id, route_id),
    by = "shape_id"
  ) |>
  left_join(
    nyc_subway_routes_df |>
      select(
        route_id,
        route_group,
        route_short_name,
        route_long_name,
        route_color
      ),
    by = "route_id"
  ) |>
  select(
    shape_id,
    route_id,
    route_group,
    route_short_name,
    route_long_name,
    route_color,
    geometry
  ) |>
  st_transform(crs = st_crs("EPSG:2263"))

usethis::use_data(nyc_subway_routes_sf, overwrite = TRUE, compress = "xz")

# ---- nyc_subway_stops_sf --------------------------------------------------
# All stops (parent stations + directional platforms).

nyc_subway_stops_sf <- subway_sf$stops |>
  clean_names() |>
  st_transform(crs = st_crs("EPSG:2263"))

usethis::use_data(nyc_subway_stops_sf, overwrite = TRUE, compress = "xz")

# ---- nyc_subway_stops_parent_sf -------------------------------------------
# Parent stations only (location_type == 1).

nyc_subway_stops_parent_sf <- nyc_subway_stops_sf |>
  filter(location_type == 1)

usethis::use_data(
  nyc_subway_stops_parent_sf,
  overwrite = TRUE,
  compress = "xz"
)

# ---- nyc_subway_stops_platform_sf -----------------------------------------
# Directional platforms only (location_type is NA; rows link to a parent
# station via parent_station).

nyc_subway_stops_platform_sf <- nyc_subway_stops_sf |>
  filter(is.na(location_type))

usethis::use_data(
  nyc_subway_stops_platform_sf,
  overwrite = TRUE,
  compress = "xz"
)

# ---- nyc_subway_transfers_df ----------------------------------------------
# Transfer pairs from the GTFS transfers.txt file.

nyc_subway_transfers_df <- subway_gtfs$transfers |>
  as_tibble() |>
  clean_names()

usethis::use_data(nyc_subway_transfers_df, overwrite = TRUE, compress = "xz")

# ---- Offset helpers -------------------------------------------------------
# Small helpers used to build visually-offset routes/stops for schematic
# maps so that overlapping services can be distinguished. Used only here.

offset_geometry <- function(geom, x_offset, y_offset = 0) {
  coords <- st_coordinates(geom)
  coords[, "X"] <- coords[, "X"] + x_offset
  coords[, "Y"] <- coords[, "Y"] + y_offset
  st_sfc(st_linestring(coords[, c("X", "Y")]), crs = st_crs(geom))
}

offset_point <- function(geom, x_offset, y_offset = 0) {
  coords <- st_coordinates(geom)
  st_sfc(
    st_point(c(coords[1, "X"] + x_offset, coords[1, "Y"] + y_offset)),
    crs = st_crs(geom)
  )
}

# ---- nyc_subway_routes_offset_sf ------------------------------------------
# Route shapes with per-route horizontal offsets (in feet, CRS 2263) so
# that co-running services draw as parallel lines in schematic maps.

n_routes <- n_distinct(nyc_subway_routes_sf$route_id)

nyc_subway_routes_offset_sf <- nyc_subway_routes_sf |>
  group_by(route_id) |>
  mutate(x_offset = (cur_group_id() - n_routes / 2) * 100) |>
  ungroup() |>
  rowwise() |>
  mutate(geometry = offset_geometry(geometry, x_offset)) |>
  ungroup() |>
  st_as_sf()

usethis::use_data(
  nyc_subway_routes_offset_sf,
  overwrite = TRUE,
  compress = "xz"
)

route_offsets <- nyc_subway_routes_offset_sf |>
  st_drop_geometry() |>
  distinct(route_id, x_offset)

route_colors <- nyc_subway_routes_offset_sf |>
  st_drop_geometry() |>
  distinct(route_id, route_color) |>
  drop_na()

# ---- nyc_subway_stops_offset_sf -------------------------------------------
# Directional platforms joined to routes and offset horizontally so that
# each service draws its own stop marker alongside the offset route line.
# We join route_groups here, too.

nyc_subway_stops_offset_sf <- subway_sf$stops |>
  clean_names() |>
  filter(is.na(location_type)) |>
  st_transform(crs = st_crs("EPSG:2263")) |>
  left_join(
    subway_sf$stop_times |>
      select(stop_id, trip_id) |>
      left_join(
        subway_sf$trips |>
          select(trip_id, route_id),
        by = "trip_id"
      ) |>
      distinct(stop_id, route_id),
    by = "stop_id"
  ) |>
  left_join(route_offsets, by = "route_id") |>
  left_join(route_colors, by = "route_id") |>
  left_join(route_groups_df, by = "route_id") |>
  relocate(route_group, .after = route_id) |>
  filter(!is.na(x_offset)) |>
  rowwise() |>
  mutate(geometry = offset_point(geometry, x_offset)) |>
  ungroup() |>
  st_as_sf()

usethis::use_data(
  nyc_subway_stops_offset_sf,
  overwrite = TRUE,
  compress = "xz"
)

# ---- nyc_subway_stop_routes_df --------------------------------------------
# Parent stop x route service map. Joins platform-level stop_times to trips
# to get (platform, route), then rolls platforms up to their parent station.

platform_to_parent <- subway_gtfs$stops |>
  as_tibble() |>
  clean_names() |>
  filter(is.na(location_type)) |>
  select(stop_id, parent_station)

nyc_subway_stop_routes_df <- subway_gtfs$stop_times |>
  as_tibble() |>
  select(stop_id, trip_id) |>
  inner_join(
    subway_gtfs$trips |>
      as_tibble() |>
      select(trip_id, route_id),
    by = "trip_id"
  ) |>
  inner_join(platform_to_parent, by = "stop_id") |>
  distinct(stop_id = parent_station, route_id) |>
  arrange(stop_id, route_id)

usethis::use_data(
  nyc_subway_stop_routes_df,
  overwrite = TRUE,
  compress = "xz"
)

# ---- Bridge: station_complex_id <-> parent stop_id -----------------------
# The MTA GTFS feed used here does not include station_complexes.txt, so
# the bridge is reconstructed by spatial nearest-match from each parent
# station to the centroid published in nycsubwayhourly. A 1500-ft cutoff
# excludes Staten Island Railway parents that have no subway-mode complex
# but would otherwise snap to the nearest mainland subway centroid.

complex_match_threshold_ft <- 1500

hourly_complex_centroids <- (function() {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))
  DBI::dbGetQuery(
    con,
    paste0(
      "SELECT DISTINCT station_complex_id, station_complex, borough, ",
      "latitude, longitude FROM read_parquet('",
      nycsubwayhourly::nyc_subway_hourly_path(),
      "') WHERE transit_mode = 'subway'"
    )
  ) |>
    as_tibble() |>
    group_by(station_complex_id) |>
    summarise(
      station_complex_name = first(station_complex),
      borough = first(borough),
      latitude = mean(latitude),
      longitude = mean(longitude),
      .groups = "drop"
    )
})()

complex_centroids_sf <- hourly_complex_centroids |>
  st_as_sf(coords = c("longitude", "latitude"), crs = 4326) |>
  st_transform(2263)

parents_2263 <- nyc_subway_stops_parent_sf |>
  st_transform(2263)

nearest_idx <- st_nearest_feature(parents_2263, complex_centroids_sf)
parent_assign <- tibble(
  stop_id = parents_2263$stop_id,
  station_complex_id = complex_centroids_sf$station_complex_id[nearest_idx],
  dist_ft = as.numeric(st_distance(
    parents_2263,
    complex_centroids_sf[nearest_idx, ],
    by_element = TRUE
  ))
) |>
  filter(dist_ft <= complex_match_threshold_ft) |>
  select(station_complex_id, stop_id)

# Sanity: every hourly subway complex must be matched to at least one parent.
stopifnot(setequal(
  parent_assign$station_complex_id,
  hourly_complex_centroids$station_complex_id
))

# ---- nyc_subway_complex_stops_df ------------------------------------------
# Long-form mapping: one row per (complex, parent stop_id).

nyc_subway_complex_stops_df <- parent_assign |>
  arrange(station_complex_id, stop_id)

usethis::use_data(
  nyc_subway_complex_stops_df,
  overwrite = TRUE,
  compress = "xz"
)

# ---- nyc_subway_complexes_df ---------------------------------------------
# One row per MTA station complex.

nyc_subway_complexes_df <- nyc_subway_complex_stops_df |>
  count(station_complex_id, name = "n_stops") |>
  inner_join(
    hourly_complex_centroids |>
      select(station_complex_id, station_complex_name, borough),
    by = "station_complex_id"
  ) |>
  relocate(station_complex_name, borough, .after = station_complex_id) |>
  arrange(station_complex_id)

usethis::use_data(
  nyc_subway_complexes_df,
  overwrite = TRUE,
  compress = "xz"
)

# ---- nyc_subway_complexes_sf ---------------------------------------------
# Centroid geometry per complex. The centroid is the mean of constituent
# parent-stop point geometries in EPSG:2263, not the published latitude
# and longitude (which sits on or near a single parent stop).

complex_centroid_geom <- nyc_subway_complex_stops_df |>
  inner_join(
    parents_2263 |> select(stop_id),
    by = "stop_id"
  ) |>
  st_as_sf() |>
  group_by(station_complex_id) |>
  summarise(
    geometry = st_centroid(st_union(geometry)),
    .groups = "drop"
  )

nyc_subway_complexes_sf <- nyc_subway_complexes_df |>
  inner_join(complex_centroid_geom, by = "station_complex_id") |>
  st_as_sf()

usethis::use_data(
  nyc_subway_complexes_sf,
  overwrite = TRUE,
  compress = "xz"
)

# ---- nyc_subway_complex_routes_df -----------------------------------------
# The flat (complex x route) join. The unique key is
# (station_complex_id, route_id).

nyc_subway_complex_routes_df <- nyc_subway_complex_stops_df |>
  inner_join(nyc_subway_stop_routes_df, by = "stop_id") |>
  distinct(station_complex_id, route_id) |>
  arrange(station_complex_id, route_id)

usethis::use_data(
  nyc_subway_complex_routes_df,
  overwrite = TRUE,
  compress = "xz"
)
