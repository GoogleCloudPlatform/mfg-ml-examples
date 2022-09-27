view: customizedpayload_numeric_cncmilling {
  fields_hidden_by_default: no
  extension: required
  view_label: "Payload"

  measure: x1_actual_position_avg{
    type: average
    description: "Actual position along x-axis (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "X1 Actual Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_x1_actualposition"]
  }

  measure: x1_command_position_avg{
    type: average
    description: "Command position along x-axis (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "X1 Command Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_x1_commandposition"]
  }

  measure: y1_actual_position_avg{
    type: average
    description: "Actual position along y-axis (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "Y1 Actual Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_y1_actualposition"]
  }

  measure: y1_command_position_avg{
    type: average
    description: "Command position along y-axis (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "Y1 Command Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_y1_commandposition"]
  }

  measure: z1_actual_position_avg{
    type: average
    description: "Actual position along z-axis (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "Z1 Actual Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_z1_actualposition"]
  }

  measure: z1_command_position_avg{
    type: average
    description: "Command position along z-axis (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "Z1 Command Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_z1_commandposition"]
  }

  measure: s1_actual_position_avg{
    type: average
    description: "Actual position for spindle (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "S1 Actual Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_s1_actualposition"]
  }

  measure: s1_command_position_avg{
    type: average
    description: "Command position for spindle (average)"
    view_label: "Payload"
    group_label: "CNC Mill"
    label: "S1 Command Position"
    sql: ${data_series_numeric.value} ;;
    filters: [data_series_numeric.tag_name: "cncmilling_s1_commandposition"]
  }
}
