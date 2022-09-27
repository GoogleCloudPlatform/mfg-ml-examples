view: payloadList {
  view_label: "View Payload - Nested List"

  dimension: payload_key {
    type: string
    sql: ${TABLE}.payloadKey;;
  }

  dimension: payload_value {
    type: string
    sql: ${TABLE}.payloadValue;;
  }

  dimension: payload_filter{
    sql: concat(${payload_key},"/",${payload_value}) ;;
    type: string
  }

  measure: payload_values {
    sql:  STRING_AGG(DISTINCT ${payload_value})  ;;
  }
}
