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
