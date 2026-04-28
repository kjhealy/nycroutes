# NYC subway parent-stop route service map

Long-form mapping from each parent subway station to the GTFS routes
that call at it. One row per `(stop_id, route_id)` pair.

## Usage

``` r
nyc_subway_stop_routes_df
```

## Format

### `nyc_subway_stop_routes_df`

A tibble with one row per parent stop and route:

- stop_id:

  GTFS parent station identifier (`location_type == 1`); joins to
  [nyc_subway_stops_parent_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_parent_sf.md).

- route_id:

  GTFS route identifier; joins to
  [nyc_subway_routes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_routes_df.md).

## Source

<https://new.mta.info/developers>

## Details

Built by joining `stop_times.txt` to `trips.txt` and rolling the
platform-level `stop_id` up to its `parent_station`. Includes any
express or branch service variants (e.g., `7X`, `FX`) that call at the
stop in the GTFS schedule, even when those variants do not appear in the
route bullets in `nycsubwayhourly`'s `station_complex` text.

## See also

[nyc_subway_complex_routes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complex_routes_df.md)
for the same information rolled up to MTA station complexes.

## Author

Kieran Healy
