#' NYC subway stops
#'
#' Point locations of every NYC subway stop in the MTA GTFS feed,
#' including both parent stations and their directional platforms.
#' EPSG:2263, NAD83 / New York Long Island (ftUS).
#'
#' @format ## `nyc_subway_stops_sf`
#' A simple feature collection with 1,488 rows and 5 columns:
#' \describe{
#'   \item{stop_id}{GTFS stop identifier. Parent stations use a bare
#'     id (e.g., `"101"`); directional platforms append `N` or `S`
#'     (e.g., `"101N"`, `"101S"`).}
#'   \item{stop_name}{Human-readable station or platform name.}
#'   \item{location_type}{GTFS location type. `1` indicates a parent
#'     station; `NA` indicates a directional platform (child stop).}
#'   \item{parent_station}{For platforms, the `stop_id` of the parent
#'     station; `NA` for parent stations themselves.}
#'   \item{geometry}{Point geometry in EPSG:2263.}
#' }
#' @details
#' Built from `stops.txt` in the MTA NYC Transit subway GTFS feed.
#' See also [nyc_subway_stops_parent_sf] for parent stations only
#' and [nyc_subway_stops_platform_sf] for directional platforms
#' only.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_stops_sf"
