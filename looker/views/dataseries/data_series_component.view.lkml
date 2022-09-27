include: "../../customization/views/*.view"
include: "../dataseries/data_series_common.view"


view: data_series_component {
  label: " Data series Component - @{looker_projectName}"
  extends: [
    data_series_common_timestamp,
    customizedtag_component,
    customizedqualifiers_component,
    customizedpayload_component
  ]

  sql_table_name: `sfp_data.ComponentDataSeries`
    ;;

  dimension: component_id {
    description: "ID of the Component."
    type: string
    sql: ${TABLE}.componentId ;;
  }

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
