# NYC subway stops with schematic offsets

Directional platform stops joined to the services that call at them,
with the same horizontal offsets applied as in
[nyc_subway_routes_offset_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_routes_offset_sf.md).
Each stop appears once per serving route so that stop markers align with
the corresponding offset route line. EPSG:2263, NAD83 / New York Long
Island (ftUS).

## Usage

``` r
nyc_subway_stops_offset_sf
```

## Format

### `nyc_subway_stops_offset_sf`

A simple feature collection with 1,909 rows and 8 columns:

- stop_id:

  GTFS platform identifier.

- stop_name:

  Station name.

- location_type:

  GTFS location type; always `NA` here (platforms only).

- parent_station:

  `stop_id` of the owning parent station.

- route_id:

  GTFS route identifier of a service calling at the stop. A stop may
  appear in multiple rows, one per route.

- x_offset:

  Horizontal offset in feet applied to the geometry.

- route_color:

  Brand color as a hex string prefixed with `#`.

- geometry:

  Offset point geometry in EPSG:2263.

## Source

<https://new.mta.info/developers>

## Details

Built by joining the platforms in
[nyc_subway_stops_platform_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_platform_sf.md)
to route ids via `stop_times.txt` and `trips.txt`, then applying the
same per-route offsets as
[nyc_subway_routes_offset_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_routes_offset_sf.md).
This is a cosmetic transformation intended only for schematic
visualization; for any spatial analysis use
[nyc_subway_stops_platform_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_platform_sf.md)
instead.

## Author

Kieran Healy
