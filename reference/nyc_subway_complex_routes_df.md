# NYC subway complex-to-route service map

Flat join between MTA station complexes and the GTFS routes that call at
any of their constituent parent stops. One row per
`(station_complex_id, route_id)` pair.

## Usage

``` r
nyc_subway_complex_routes_df
```

## Format

### `nyc_subway_complex_routes_df`

A tibble with one row per (complex, route):

- station_complex_id:

  MTA complex identifier; joins to
  [nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md).

- route_id:

  GTFS route identifier; joins to
  [nyc_subway_routes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_routes_df.md).

## Source

<https://new.mta.info/developers>

## Details

Equivalent to
`nyc_subway_complex_stops_df |> inner_join(nyc_subway_stop_routes_df, by = "stop_id") |> distinct()`.
Provided directly because almost every consuming script wants it.
Includes express and branch service variants (e.g., `7X`, `FX`) that may
not appear in the route bullets in `nycsubwayhourly`'s `station_complex`
text.

## See also

[nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md),
[nyc_subway_stop_routes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stop_routes_df.md).

## Author

Kieran Healy
