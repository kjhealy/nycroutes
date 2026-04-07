# NYC subway parent stations

Point locations of the 496 parent subway stations
(`location_type == 1`). Each parent station corresponds to one or more
directional platforms in
[nyc_subway_stops_platform_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_platform_sf.md).
EPSG:2263, NAD83 / New York Long Island (ftUS).

## Usage

``` r
nyc_subway_stops_parent_sf
```

## Format

### `nyc_subway_stops_parent_sf`

A simple feature collection with 496 rows and 5 columns:

- stop_id:

  GTFS stop identifier for the parent station.

- stop_name:

  Station name.

- location_type:

  GTFS location type; always `1` here.

- parent_station:

  Always `NA` for parent stations.

- geometry:

  Point geometry in EPSG:2263.

## Source

<https://new.mta.info/developers>

## Details

Filtered from
[nyc_subway_stops_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_sf.md)
on `location_type == 1`.

## Author

Kieran Healy
