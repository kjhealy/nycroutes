# nycroutes 0.0.4.9000

* Added `nyc_subway_stop_routes_df`, a long-form mapping from each
  parent subway station to the GTFS routes that call at it.
* Added `nyc_subway_complexes_df` and `nyc_subway_complexes_sf`, with
  one row per MTA station complex and (in the sf version) the centroid
  geometry of the constituent parent stops.
* Added `nyc_subway_complex_stops_df`, the long-form bridge between
  MTA `station_complex_id` and GTFS parent `stop_id`.
* Added `nyc_subway_complex_routes_df`, the flat join giving the
  routes that serve each MTA station complex. Lets downstream code
  drop ad-hoc parsing of route bullets from the `station_complex`
  text in `nycsubwayhourly`.
