# NYC subway station complexes (sf)

Centroid geometry for each MTA station complex, with the same scalar
columns as
[nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md).
EPSG:2263, NAD83 / New York Long Island (ftUS).

## Usage

``` r
nyc_subway_complexes_sf
```

## Format

### `nyc_subway_complexes_sf`

A simple feature collection with one row per complex:

- station_complex_id:

  MTA complex identifier.

- station_complex_name:

  Canonical complex name.

- borough:

  Borough.

- n_stops:

  Number of GTFS parent stops in the complex.

- geometry:

  Point centroid in EPSG:2263, computed as the centroid of the
  constituent parent-stop point geometries.

## Source

<https://new.mta.info/developers>

## Details

The centroid is the mean of the constituent parent-stop point
geometries, not the single `(latitude, longitude)` published in
`nycsubwayhourly` (which sits on or near a single parent stop).

## See also

[nyc_subway_complexes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_df.md)
for the non-spatial version;
[nyc_subway_complex_stops_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complex_stops_df.md)
and
[nyc_subway_stops_parent_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_stops_parent_sf.md)
for the constituent parent stops.

## Author

Kieran Healy
