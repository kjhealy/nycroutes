# NYC subway station complexes

One row per MTA station complex. The complex is the unit of aggregation
used in the ridership data published by the MTA (notably
`nycsubwayhourly` and `nycsubwayodr`), and may aggregate multiple GTFS
parent stops (for instance, Times Sq–42 St aggregates five parent stops
across the IRT, BMT, and IND lines).

## Usage

``` r
nyc_subway_complexes_df
```

## Format

### `nyc_subway_complexes_df`

A tibble with one row per complex:

- station_complex_id:

  MTA complex identifier as used in `nycsubwayhourly` and
  `nycsubwayodr`.

- station_complex_name:

  Canonical human-readable complex name.

- borough:

  Borough containing the complex.

- n_stops:

  Number of GTFS parent stops belonging to the complex.

## Source

<https://new.mta.info/developers>

## Details

Subway-only. Staten Island Railway and Roosevelt Island Tramway
complexes that appear in `nycsubwayhourly` are intentionally not
included here because the underlying GTFS feed used by `nycroutes` is
the subway feed (`gtfs_subway.zip`).

Complex membership is reconstructed from the GTFS feed because the MTA's
subway GTFS feed used by this package does not include
`station_complexes.txt`. Each parent station is assigned to the nearest
centroid in `nycsubwayhourly`'s station-complex centroid table, with a
1500 ft cutoff (in EPSG:2263) to exclude SIR parents that would
otherwise snap to mainland subway centroids.

## See also

[nyc_subway_complex_stops_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complex_stops_df.md),
[nyc_subway_complex_routes_df](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complex_routes_df.md),
[nyc_subway_complexes_sf](https://kjhealy.github.io/nycroutes/reference/nyc_subway_complexes_sf.md).

## Author

Kieran Healy
