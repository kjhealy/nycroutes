#' NYC subway directional platforms
#'
#' Point locations of the 992 directional platforms (child stops
#' with `is.na(location_type)`). Each platform has a `parent_station`
#' id linking to a row in [nyc_subway_stops_parent_sf]. EPSG:2263,
#' NAD83 / New York Long Island (ftUS).
#'
#' @format ## `nyc_subway_stops_platform_sf`
#' A simple feature collection with 992 rows and 5 columns:
#' \describe{
#'   \item{stop_id}{GTFS platform identifier, typically the parent
#'     `stop_id` with a trailing `N` or `S` for direction.}
#'   \item{stop_name}{Station name (usually the same as the parent).}
#'   \item{location_type}{GTFS location type; always `NA` here.}
#'   \item{parent_station}{`stop_id` of the owning parent station.}
#'   \item{geometry}{Point geometry in EPSG:2263.}
#' }
#' @details
#' Filtered from [nyc_subway_stops_sf] on `is.na(location_type)`.
#' Directional platforms are the rows referenced by GTFS
#' `stop_times.txt` and are what should be joined against trip
#' data.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_stops_platform_sf"
