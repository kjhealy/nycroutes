# NYC subway directional platforms

Point locations of the 992 directional platforms (child stops with
`is.na(location_type)`). Each platform has a `parent_station` id linking
to a row in
[nyc_subway_stops_parent_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_parent_sf.md).
EPSG:2263, NAD83 / New York Long Island (ftUS).

## Usage

``` r
nyc_subway_stops_platform_sf
```

## Format

### `nyc_subway_stops_platform_sf`

A simple feature collection with 992 rows and 5 columns:

- stop_id:

  GTFS platform identifier, typically the parent `stop_id` with a
  trailing `N` or `S` for direction.

- stop_name:

  Station name (usually the same as the parent).

- location_type:

  GTFS location type; always `NA` here.

- parent_station:

  `stop_id` of the owning parent station.

- geometry:

  Point geometry in EPSG:2263.

## Source

<https://new.mta.info/developers>

## Details

Filtered from
[nyc_subway_stops_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_sf.md)
on `is.na(location_type)`. Directional platforms are the rows referenced
by GTFS `stop_times.txt` and are what should be joined against trip
data.

## Author

Kieran Healy
