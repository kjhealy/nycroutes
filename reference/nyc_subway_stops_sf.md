# NYC subway stops

Point locations of every NYC subway stop in the MTA GTFS feed, including
both parent stations and their directional platforms. EPSG:2263, NAD83 /
New York Long Island (ftUS).

## Usage

``` r
nyc_subway_stops_sf
```

## Format

### `nyc_subway_stops_sf`

A simple feature collection with 1,488 rows and 5 columns:

- stop_id:

  GTFS stop identifier. Parent stations use a bare id (e.g., `"101"`);
  directional platforms append `N` or `S` (e.g., `"101N"`, `"101S"`).

- stop_name:

  Human-readable station or platform name.

- location_type:

  GTFS location type. `1` indicates a parent station; `NA` indicates a
  directional platform (child stop).

- parent_station:

  For platforms, the `stop_id` of the parent station; `NA` for parent
  stations themselves.

- geometry:

  Point geometry in EPSG:2263.

## Source

<https://new.mta.info/developers>

## Details

Built from `stops.txt` in the MTA NYC Transit subway GTFS feed. See also
[nyc_subway_stops_parent_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_parent_sf.md)
for parent stations only and
[nyc_subway_stops_platform_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_platform_sf.md)
for directional platforms only.

## Author

Kieran Healy
