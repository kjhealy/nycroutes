#' NYC subway parent stations
#'
#' Point locations of the 496 parent subway stations
#' (`location_type == 1`). Each parent station corresponds to one or
#' more directional platforms in [nyc_subway_stops_platform_sf].
#' EPSG:2263, NAD83 / New York Long Island (ftUS).
#'
#' @format ## `nyc_subway_stops_parent_sf`
#' A simple feature collection with 496 rows and 5 columns:
#' \describe{
#'   \item{stop_id}{GTFS stop identifier for the parent station.}
#'   \item{stop_name}{Station name.}
#'   \item{location_type}{GTFS location type; always `1` here.}
#'   \item{parent_station}{Always `NA` for parent stations.}
#'   \item{geometry}{Point geometry in EPSG:2263.}
#' }
#' @details
#' Filtered from [nyc_subway_stops_sf] on `location_type == 1`.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_stops_parent_sf"
