- dashboard: cymbal_fabrication_cnc_mill
  title: Cymbal Fabrication CNC Mill
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: rUqSOacETMwusKJ9CnxRun
  elements:
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: <img width="200px" src="https://storage.googleapis.com/gc-mde-demo-public/cymbal_fabrication_brand.png"/>
    row: 1
    col: 0
    width: 4
    height: 3
  - name: " (2)"
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: <img width="250px" src="https://storage.googleapis.com/gc-mde-demo-public/cnc_mill.jpeg"/>
    row: 4
    col: 0
    width: 4
    height: 5
  - name: Asset Information
    type: text
    title_text: Asset Information
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 1
  - name: Prediction Details
    type: text
    title_text: Prediction Details
    body_text: ''
    row: 9
    col: 0
    width: 24
    height: 1
  - title: Latest Prediction
    name: Latest Prediction
    model: mde-ml
    explore: data_series_discrete
    type: single_value
    fields: [data_series_discrete.timestamp_event_time, data_series_discrete.predicted_tool_condition]
    filters:
      data_series_discrete.tag_name: '"tool_wear_predictions"'
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 1
    query_timezone: America/New_York
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields: [data_series_discrete.timestamp_event_time]
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 1
    col: 4
    width: 6
    height: 2
  - title: Latest Prediction Timestamp
    name: Latest Prediction Timestamp
    model: mde-ml
    explore: data_series_discrete
    type: single_value
    fields: [data_series_discrete.timestamp_event_time]
    filters:
      data_series_discrete.tag_name: '"tool_wear_predictions"'
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 1
    query_timezone: America/New_York
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    defaults_version: 1
    hidden_fields:
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 1
    col: 10
    width: 7
    height: 2
  - title: Prediction Features
    name: Prediction Features
    model: mde-ml
    explore: data_series_discrete
    type: looker_grid
    fields: [data_series_discrete.timestamp_event_time, data_series_discrete.instance_json]
    filters:
      data_series_discrete.tag_name: '"tool_wear_predictions"'
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [data_series_discrete.timestamp_event_time]
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 16
    col: 11
    width: 6
    height: 9
  - title: Prediction
    name: Prediction
    model: mde-ml
    explore: data_series_discrete
    type: looker_grid
    fields: [data_series_discrete.timestamp_event_time, data_series_discrete.payload_json]
    filters:
      data_series_discrete.tag_name: '"tool_wear_predictions"'
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: false
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    defaults_version: 1
    hidden_fields: [data_series_discrete.timestamp_event_time]
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 16
    col: 0
    width: 11
    height: 9
  - title: Past Predictions
    name: Past Predictions
    model: mde-ml
    explore: data_series_discrete
    type: looker_grid
    fields: [data_series_discrete.timestamp_event_time, data_series_discrete.tag_name,
      data_series_discrete.message_id, data_series_discrete.predicted_tool_condition,
      data_series_discrete.score]
    filters:
      data_series_discrete.tag_name: '"tool_wear_predictions"'
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 521507ed-11a8-af75-228c-6ac264952caf, label: Custom, type: continuous,
            stops: [{color: "#ff0000", offset: 0}, {color: "#ffff00", offset: 50},
              {color: "#00ff00", offset: 100}]}, options: {steps: 5, constraints: {
              min: {type: number, value: 0}, mid: {type: number, value: 0.5}, max: {
                type: number, value: 1}}}}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 10
    col: 0
    width: 24
    height: 6
  - title: Uncertain Predictions
    name: Uncertain Predictions
    model: mde-ml
    explore: data_series_discrete
    type: looker_grid
    fields: [data_series_discrete.timestamp_event_time, data_series_discrete.tag_name,
      data_series_discrete.message_id, data_series_discrete.predicted_tool_condition,
      data_series_discrete.score]
    filters:
      data_series_discrete.tag_name: '"tool_wear_predictions"'
      data_series_discrete.score: "[0.3, 0.7]"
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 500
    column_limit: 50
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#4285F4",
        font_color: !!null '', color_application: {collection_id: google, custom: {
            id: 521507ed-11a8-af75-228c-6ac264952caf, label: Custom, type: continuous,
            stops: [{color: "#ff0000", offset: 0}, {color: "#ffff00", offset: 50},
              {color: "#00ff00", offset: 100}]}, options: {steps: 5, constraints: {
              min: {type: number, value: 0}, mid: {type: number, value: 0.5}, max: {
                type: number, value: 1}}}}, bold: false, italic: false, strikethrough: false,
        fields: !!null ''}]
    defaults_version: 1
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 26
    col: 5
    width: 19
    height: 6
  - name: Model Analysis
    type: text
    title_text: Model Analysis
    body_text: ''
    row: 25
    col: 0
    width: 24
    height: 1
  - title: Aggregated Tool Condition over Time
    name: Aggregated Tool Condition over Time
    model: mde-ml
    explore: data_series_discrete
    type: looker_line
    fields: [data_series_discrete.predicted_tool_condition_numeric_agg, data_series_discrete.timestamp_event_minute5]
    filters:
      data_series_discrete.predicted_tool_condition_numeric_agg: NOT NULL
    sorts: [data_series_discrete.timestamp_event_minute5 desc]
    limit: 200
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    hidden_fields: []
    defaults_version: 1
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 3
    col: 10
    width: 14
    height: 6
  - title: Actual and Predicted Tool Condition over Time
    name: Actual and Predicted Tool Condition over Time
    model: mde-ml
    explore: data_series_discrete
    type: looker_line
    fields: [data_series_discrete.actual_tool_condition_numeric_max, data_series_discrete.timestamp_event_time,
      data_series_discrete.predicted_tool_condition_numeric_agg]
    filters:
      data_series_discrete.predicted_tool_condition_numeric_agg: NOT NULL
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 5000
    query_timezone: user_timezone
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    hidden_fields: []
    defaults_version: 1
    hidden_series: []
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 32
    col: 0
    width: 24
    height: 6
  - title: Top Important Features
    name: Top Important Features
    model: mde-ml
    explore: data_series_discrete
    type: looker_column
    fields: [data_series_discrete.feature_attributions_value, data_series_discrete.feature_attributions_key]
    filters:
      data_series_discrete.feature_attributions_key: "-NULL"
    sorts: [absolute_feature_attribution_value desc]
    limit: 5
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'abs(${data_series_discrete.feature_attributions_value})',
        label: Absolute Feature Attribution Value, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: absolute_feature_attribution_value,
        _type_hint: number, id: eWdm33c8xC}, {category: table_calculation, expression: 'replace(${qualifiersList.qualifier_key},
          "explanation.attributions.0.featureAttributions.", "")', label: Feature
          Attribution Key, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: dimension, table_calculation: feature_attribution_key, _type_hint: string,
        id: GoDKzIFf5e, is_disabled: true}]
    query_timezone: America/New_York
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: [data_series_discrete.feature_attributions_value]
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 16
    col: 17
    width: 7
    height: 9
  - title: Asset Metadata
    name: Asset Metadata
    model: mde-ml
    explore: data_series_discrete
    type: looker_single_record
    fields: [meta.asset_equipmentId, meta.asset_equipmentType, meta.asset_equipmentLocation,
      meta.cmcmill_material, meta.organization_departmentId, meta.organization_lineId,
      meta.organization_plantId, meta.organization_processId, meta.organization_stationId]
    filters:
      meta.cmcmill_material: "-NULL"
    sorts: [meta.asset_equipmentId]
    limit: 500
    column_limit: 50
    show_view_names: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 3
    col: 4
    width: 6
    height: 6
  - title: Actions
    name: Actions
    model: mde-ml
    explore: data_series_discrete
    type: looker_grid
    fields: [data_series_discrete.action_contact_supplier, data_series_discrete.action_schedule_maintenance]
    filters:
      meta.asset_equipmentType: "-NULL"
    sorts: [data_series_discrete.action_contact_supplier]
    limit: 500
    query_timezone: America/New_York
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    title_hidden: true
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 1
    col: 17
    width: 7
    height: 2
  - title: Model Accuracy
    name: Model Accuracy
    model: mde-ml
    explore: data_series_discrete
    type: single_value
    fields: [data_series_discrete.actual_tool_condition_numeric_max, data_series_discrete.timestamp_event_time,
      data_series_discrete.predicted_tool_condition_numeric_agg]
    filters:
      data_series_discrete.predicted_tool_condition_numeric_agg: NOT NULL
    sorts: [data_series_discrete.timestamp_event_time desc]
    limit: 5000
    column_limit: 50
    dynamic_fields: [{category: table_calculation, expression: 'if(${data_series_discrete.actual_tool_condition_numeric_max}
          = ${data_series_discrete.predicted_tool_condition_numeric_agg}, 1, 0)',
        label: Match, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: match, _type_hint: number, id: sLxX2FbL6Q}, {category: table_calculation,
        expression: 'sum(${match}) / count(${data_series_discrete.actual_tool_condition_numeric_max})',
        label: Accuracy, value_format: !!null '', value_format_name: !!null '', _kind_hint: measure,
        table_calculation: accuracy, _type_hint: number, id: bQMfWqfMr9}]
    query_timezone: user_timezone
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: true
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    conditional_formatting: [{type: greater than, value: 0.8, background_color: "#34A853",
        font_color: !!null '', color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}, {type: not
          null, value: !!null '', background_color: "#EA4335", font_color: !!null '',
        color_application: {collection_id: google, palette_id: google-sequential-0},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    hidden_fields: [match, data_series_discrete.predicted_tool_condition_numeric_agg,
      data_series_discrete.actual_tool_condition_numeric_max, data_series_discrete.timestamp_event_time]
    defaults_version: 1
    hidden_series: []
    series_types: {}
    listen:
      Message ID: data_series_discrete.message_id
      Time window filter: data_series_discrete.timeinterval_filter
      Score Threshold: data_series_discrete.score_threshold
    row: 26
    col: 0
    width: 5
    height: 6
  filters:
  - name: Time window filter
    title: Time window filter
    type: field_filter
    default_value: 3 day
    allow_multiple_values: true
    required: true
    ui_config:
      type: advanced
      display: popover
      options: []
    model: mde-ml
    explore: data_series_discrete
    listens_to_filters: []
    field: data_series_discrete.timeinterval_filter
  - name: Score Threshold
    title: Score Threshold
    type: field_filter
    default_value: ">=0.5"
    allow_multiple_values: false
    required: true
    ui_config:
      type: advanced
      display: popover
      options:
      - '1'
      - '2'
      - '3'
    model: mde-ml
    explore: data_series_discrete
    listens_to_filters: []
    field: data_series_discrete.score_threshold
  - name: Message ID
    title: Message ID
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: mde-ml
    explore: data_series_discrete
    listens_to_filters: []
    field: data_series_discrete.message_id
