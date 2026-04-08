#' NYC subway stops with schematic offsets
#'
#' Directional platform stops joined to the services that call at
#' them, with the same horizontal offsets applied as in
#' [nyc_subway_routes_offset_sf]. Each stop appears once per
#' serving route so that stop markers align with the corresponding
#' offset route line. EPSG:2263, NAD83 / New York Long Island
#' (ftUS).
#'
#' @format ## `nyc_subway_stops_offset_sf`
#' A simple feature collection with 1,909 rows and 8 columns:
#' \describe{
#'   \item{stop_id}{GTFS platform identifier.}
#'   \item{stop_name}{Station name.}
#'   \item{location_type}{GTFS location type; always `NA` here
#'     (platforms only).}
#'   \item{parent_station}{`stop_id` of the owning parent station.}
#'   \item{route_id}{GTFS route identifier of a service calling at
#'     the stop. A stop may appear in multiple rows, one per route.}
#'   \item{route_group}{Route group identifier (e.g., `"ACE"`, `"123"`).}
#'   \item{x_offset}{Horizontal offset in feet applied to the
#'     geometry.}
#'   \item{route_color}{Brand color as a hex string prefixed with
#'     `#`.}
#'   \item{geometry}{Offset point geometry in EPSG:2263.}
#' }
#' @details
#' Built by joining the platforms in [nyc_subway_stops_platform_sf]
#' to route ids via `stop_times.txt` and `trips.txt`, then applying
#' the same per-route offsets as [nyc_subway_routes_offset_sf].
#' This is a cosmetic transformation intended only for schematic
#' visualization; for any spatial analysis use
#' [nyc_subway_stops_platform_sf] instead.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_stops_offset_sf"
