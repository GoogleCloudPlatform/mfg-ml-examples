view: qualifiersList {
  view_label: "View Qualifiers - Nested List"

  filter: qualifier_filter{
    sql: concat(${qualifier_key},"/",${qualifier_value}) ;;
    type: string
  }

  dimension: qualifier_key {
    type: string
    sql: ${TABLE}.qualifierKey;;
  }

  dimension: qualifier_value {
    type: string
    sql: ${TABLE}.qualifierValue;;
  }

  measure: qualifier_values {
    sql:  STRING_AGG(DISTINCT ${qualifier_value})  ;;
  }
}
