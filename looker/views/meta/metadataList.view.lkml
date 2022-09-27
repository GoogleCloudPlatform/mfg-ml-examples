view: metadataList {
  view_label: "View Metadata - Nested List"

  dimension: metadata_key {
    label: "Meta Attribute"
    type: string
    sql: ${TABLE}.metadataKey;;
  }

  dimension: metadata_value {
    label: "Value"
    type: string
    sql: ${TABLE}.metadataValue;;
  }

  dimension: metadata_filter{
    sql: concat(${metadata_key},"/",${metadata_value}) ;;
    type: string
  }

  measure: metadata_values {
    label: "Value"
    sql:  STRING_AGG(DISTINCT ${metadata_value})  ;;
  }
}
