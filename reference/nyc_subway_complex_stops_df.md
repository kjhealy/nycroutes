# NYC subway complex-to-parent-stop mapping

Long-form bridge between MTA station complexes and the GTFS parent stops
that constitute them. One row per `(station_complex_id, stop_id)` pair.

## Usage

``` r
nyc_subway_complex_stops_df
```

## Format

### `nyc_subway_complex_stops_df`

A tibble with one row per (complex, parent stop):

- station_complex_id:

  MTA complex identifier; joins to
  [nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md).

- stop_id:

  GTFS parent station identifier; joins to
  [nyc_subway_stops_parent_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_parent_sf.md).

## Source

<https://new.mta.info/developers>

## Details

Subway-only; see
[nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md)
for the construction procedure and the SIR/tram caveat.

## See also

[nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md),
[nyc_subway_complex_routes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complex_routes_df.md).

## Author

Kieran Healy
