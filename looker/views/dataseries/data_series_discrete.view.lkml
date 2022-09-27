include: "../../customization/views/*.view"
include: "../dataseries/data_series_common.view"


view: data_series_discrete {
  label: " Data series Discrete - @{looker_projectName}"
  extends: [
    data_series_common_timestamp,
    customizedtag_discrete,
    customizedqualifiers_discrete,
    customizedpayload_discrete,
  ]

  sql_table_name: `sfp_data.DiscreteDataSeries` ;;

  dimension: value {
    description: "Numerical value (if defined in payload.value) of the data series record."
    type: number
    sql: (SELECT cast(payloadValue as BIGNUMERIC) from UNNEST(${payload_kv})  where payloadKey = "value") ;;
  }

  dimension: event_type {
    description: "Type of the Event."
    type: string
    sql: ${TABLE}.eventType ;;
  }
}
