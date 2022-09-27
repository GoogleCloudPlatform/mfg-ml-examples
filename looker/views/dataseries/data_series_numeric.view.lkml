include: "../../customization/views/*.view"
include: "../dataseries/data_series_common.view"


view: data_series_numeric {
  label: " Data series Numeric - @{looker_projectName}"
  extends: [
    data_series_common_timestamp,
    customizedtag_numeric,
    customizedqualifiers_numeric,
    customizedpayload_numeric
  ]

  sql_table_name: `sfp_data.NumericDataSeries` ;;

  dimension: value {
    description: "Numerical value of the data series record."
    type: number
    sql: ${TABLE}.value ;;
  }
}
