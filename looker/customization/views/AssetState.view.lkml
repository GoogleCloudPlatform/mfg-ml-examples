view: asset_state_current {
  label: "Asset State Current"
  view_label: "Asset State Current"

  extension: required
  extends: [asset_state_common]

  dimension: asset_state {
    sql: ${current_state_json_kv} ;;
  }
}

view: asset_state_previous {
  label: "Asset State Previous"
  view_label: "Asset State Previous"

  extension: required
  extends: [asset_state_common]

  dimension: asset_state {
    sql: ${previous_state_json_kv} ;;
  }
}


view: asset_state_common {
  extension: required
  extends: [asset_state_common]

  dimension: counter_starts {
    type: string
    sql: (SELECT stateValue FROM UNNEST(${asset_state}) where stateKey = "starts") ;;
  }

  dimension: asset_uptime_cumulative {
    type: string
    sql: (SELECT stateValue FROM UNNEST(${asset_state}) where stateKey = "uptime") ;;
  }

}
