#' NYC subway route shapes
#'
#' Linestring geometries for NYC subway route shapes, one row per
#' GTFS `shape_id`. Each shape is joined to its route identifier,
#' short and long names, and brand color so that features can be
#' mapped and styled directly. EPSG:2263, NAD83 / New York Long
#' Island (ftUS).
#'
#' @format ## `nyc_subway_routes_sf`
#' A simple feature collection with 311 rows and 6 columns:
#' \describe{
#'   \item{shape_id}{GTFS shape identifier.}
#'   \item{route_id}{GTFS route identifier the shape belongs to.}
#'   \item{route_group}{Route group identifier (e.g., `"ACE"`, `"123"`).}
#'   \item{route_short_name}{Short service name (bullet letter/number).}
#'   \item{route_long_name}{Descriptive long name.}
#'   \item{route_color}{Brand color as a hex string prefixed with `#`.}
#'   \item{geometry}{Linestring geometry in EPSG:2263.}
#' }
#' @details
#' Built from `shapes.txt`, `trips.txt`, and `routes.txt` in the MTA
#' NYC Transit subway GTFS feed. A single `route_id` may be
#' represented by several shapes, one per service pattern.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_routes_sf"
