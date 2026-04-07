# NYC subway transfers

Transfer pairs between subway stops, from the GTFS `transfers.txt` file.

## Usage

``` r
nyc_subway_transfers_df
```

## Format

### `nyc_subway_transfers_df`

A tibble with 613 rows and 4 columns:

- from_stop_id:

  `stop_id` where the transfer originates.

- to_stop_id:

  `stop_id` where the transfer terminates.

- transfer_type:

  GTFS transfer type code. `0` = recommended transfer, `2` = transfer
  requires a minimum time, `3` = no transfer possible.

- min_transfer_time:

  Minimum time in seconds to complete the transfer; `NA` if not
  specified.

## Source

<https://new.mta.info/developers>

## Details

Derived from `transfers.txt` in the MTA NYC Transit subway GTFS feed.
Stop ids can be joined to
[nyc_subway_stops_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_sf.md).

## Author

Kieran Healy
