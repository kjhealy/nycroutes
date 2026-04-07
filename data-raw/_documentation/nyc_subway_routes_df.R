#' NYC subway routes
#'
#' Tabular metadata for the 29 named subway services in the MTA GTFS
#' feed, including long and short names, descriptions, brand colors,
#' and sort order.
#'
#' @format ## `nyc_subway_routes_df`
#' A tibble with 29 rows and 10 columns:
#' \describe{
#'   \item{route_id}{GTFS route identifier (e.g., `"A"`, `"FX"`).}
#'   \item{agency_id}{GTFS agency identifier (all `"MTA NYCT"`).}
#'   \item{route_short_name}{Short service name, usually the bullet
#'     letter or number shown on signage.}
#'   \item{route_long_name}{Descriptive long name (e.g., `"8 Avenue
#'     Express"`).}
#'   \item{route_desc}{Long-form description of the service.}
#'   \item{route_type}{GTFS route type code. Always `1` (subway/metro).}
#'   \item{route_url}{MTA route information URL.}
#'   \item{route_color}{Brand color as a hex string prefixed with `#`.}
#'   \item{route_text_color}{Text color for labels as a hex string
#'     prefixed with `#`.}
#'   \item{route_sort_order}{MTA-supplied sort order for presentation.}
#' }
#' @details
#' Derived from `routes.txt` in the MTA NYC Transit subway GTFS feed.
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_routes_df"
