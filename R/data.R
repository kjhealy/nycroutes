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

#' NYC subway transfers
#'
#' Transfer pairs between subway stops, from the GTFS
#' `transfers.txt` file.
#'
#' @format ## `nyc_subway_transfers_df`
#' A tibble with 613 rows and 4 columns:
#' \describe{
#'   \item{from_stop_id}{`stop_id` where the transfer originates.}
#'   \item{to_stop_id}{`stop_id` where the transfer terminates.}
#'   \item{transfer_type}{GTFS transfer type code. `0` = recommended
#'     transfer, `2` = transfer requires a minimum time, `3` = no
#'     transfer possible.}
#'   \item{min_transfer_time}{Minimum time in seconds to complete
#'     the transfer; `NA` if not specified.}
#' }
#' @details
#' Derived from `transfers.txt` in the MTA NYC Transit subway GTFS
#' feed. Stop ids can be joined to [nyc_subway_stops_sf].
#'
#' @author Kieran Healy
#' @source <https://new.mta.info/developers>
"nyc_subway_transfers_df"

