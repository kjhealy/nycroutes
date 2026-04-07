#' NYC subway route shapes with schematic offsets
#'
#' A version of [nyc_subway_routes_sf] in which each route has been
#' shifted horizontally by a small amount (in feet, CRS EPSG:2263)
#' so that co-running services can be drawn as parallel lines in
#' schematic maps instead of stacking on top of each other.
#' EPSG:2263, NAD83 / New York Long Island (ftUS).
#'
#' @format ## `nyc_subway_routes_offset_sf`
#' A simple feature collection with 311 rows and 7 columns:
#' \describe{
#'   \item{shape_id}{GTFS shape identifier.}
#'   \item{route_id}{GTFS route identifier.}
#'   \item{route_short_name}{Short service name (bullet letter/number).}
#'   \item{route_long_name}{Descriptive long name.}
#'   \item{route_color}{Brand color as a hex string prefixed with `#`.}
#'   \item{x_offset}{Horizontal offset in feet applied to the geometry.}
#'   \item{geometry}{Offset linestring geometry in EPSG:2263.}
#' }
#' @details
#' Offsets are computed as `(group_id - n_routes / 2) * 50`, so each
#' route is shifted by a multiple of 50 feet relative to the middle
#' route. This is a cosmetic transformation intended only for
#' schematic visualization; for any spatial analysis use
#' [nyc_subway_routes_sf] instead.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_routes_offset_sf"
