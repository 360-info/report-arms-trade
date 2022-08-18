# `/data`

`sipri-exports-processed.csv`: tidied TIV import/export tables from the [SIPRI Arms Transfers Database](https://www.sipri.org/databases/armstransfers), merged with group point data. (This data is also present as a geoJSON.) Columns include:
  - `supplier`: name of the supplying group
  - `recipient`: name of the receiving group
  - `year`: year of the transfers between these groups
  - `value`: Trend Indicator Value (TIV) of the transfers, in $ millions
  - `supplier_cown`: The supplier's Correlates of War numeric code, if it exists
  - `recipient_cown`: The recipient's Correlates of War numeric code, if it exists
  - `supplier_lon`: the longitude of the supplying group
  - `supplier_lat`: the latitutde of the supplying group
  - `recipient_lon`: the longitude of the receiving group
  - `recipient_lat`: the latitutde of the receiving group

`trademap-raw`: the TIV tables for each exporter as downloaded from SIPRI's website

`contracts`: Work-in-progress analysis of US budget data. This data is not ready for publication
