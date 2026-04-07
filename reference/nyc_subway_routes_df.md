# NYC subway routes

Tabular metadata for the 29 named subway services in the MTA GTFS feed,
including long and short names, descriptions, brand colors, and sort
order.

## Usage

``` r
nyc_subway_routes_df
```

## Format

### `nyc_subway_routes_df`

A tibble with 29 rows and 10 columns:

- route_id:

  GTFS route identifier (e.g., `"A"`, `"FX"`).

- agency_id:

  GTFS agency identifier (all `"MTA NYCT"`).

- route_short_name:

  Short service name, usually the bullet letter or number shown on
  signage.

- route_long_name:

  Descriptive long name (e.g., `"8 Avenue Express"`).

- route_desc:

  Long-form description of the service.

- route_type:

  GTFS route type code. Always `1` (subway/metro).

- route_url:

  MTA route information URL.

- route_color:

  Brand color as a hex string prefixed with `#`.

- route_text_color:

  Text color for labels as a hex string prefixed with `#`.

- route_sort_order:

  MTA-supplied sort order for presentation.

## Source

<https://new.mta.info/developers>

## Details

Derived from `routes.txt` in the MTA NYC Transit subway GTFS feed.

## Author

Kieran Healy
