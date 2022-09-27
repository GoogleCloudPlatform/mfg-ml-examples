connection: "@{looker_connection}"
label: "@{looker_projectName}"

include: "../views/configmanager/@{gcp_imde_configmgmt_storagetype}/meta.view"
include: "../views/persistence.view"


include: "../views/dataseries/*.view"
include: "../views/meta/*.view"

include: "../customization/views/*.view"
include: "../customization/dashboards/*.dashboard"


datagroup: default_datagroup {
  max_cache_age: "@{default_cache_refresh}"
}

persist_with: default_datagroup

explore: data_series_numeric {

  label: "Data Series - Numeric"
  sql_always_where: ${data_series_numeric.timestamp_event_raw} between {% date_start data_series_numeric.timeinterval_filter %} and {% date_end data_series_numeric.timeinterval_filter %} ;;

  conditionally_filter: {
    filters: [data_series_numeric.timeinterval_filter: "4 hours "]
    unless: [data_series_numeric.timestamp_event_date,data_series_numeric.timestamp_event_time,data_series_numeric.timestamp_event_raw]
  }

  join: meta {
    from: meta
    sql_on: ${data_series_numeric.tag_name}=${meta.tag_name} ;;
    relationship: many_to_one
  }

  join: meta_attribute{
    required_joins: [meta]
    sql: LEFT JOIN UNNEST( meta.metadata_attributes) as meta_attribute ;;
    relationship: one_to_many
  }

  join: qualifiersList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_numeric.qualifier_kv}) as qualifiersList ;;
  }

  # This additional join allows to pivot the metadata values over the metadataKey
  # In the scenario using the CloudSQL federation - the functionality comes with the metajoin
  #join: metadataList  {
  #  relationship: one_to_many
  #  sql: LEFT JOIN UNNEST(${meta.metadata_attributes}) as metadataList ;;
  #  #sql: LEFT JOIN UNNEST(${data_series_numeric.metadata_json_kv}) as metadataList ;;
  #  #sql: LEFT JOIN UNNEST(${data_series_numeric.metadata_kv}) as metadataList ;;
  #}

  join: payloadList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_numeric.payload_kv}) as payloadList ;;
  }
}

explore: data_series_discrete {
  view_name: data_series_discrete
  label: "Data Series - Discrete"
  sql_always_where: ${data_series_discrete.timestamp_event_raw} between {% date_start data_series_discrete.timeinterval_filter %} and {% date_end data_series_discrete.timeinterval_filter %} ;;

  conditionally_filter: {
    filters: [data_series_discrete.timeinterval_filter: "4 hours "]
    unless: [data_series_discrete.timestamp_event_date,data_series_discrete.timestamp_event_time,data_series_discrete.timestamp_event_raw]
  }

  join: meta {
    from: meta
    sql_on: ${data_series_discrete.tag_name}=${meta.tag_name} ;;
    relationship: many_to_one
  }
  join: meta_attribute{
    required_joins: [meta]
    sql: LEFT JOIN UNNEST( meta.metadata_attributes) as meta_attribute ;;
    relationship: one_to_many
  }

  join: qualifiersList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_discrete.qualifier_kv}) as qualifiersList ;;
  }
  # This additional join allows to pivot the metadata values over the metadataKey
  # In the scenario using the CloudSQL federation - the functionality comes with the metajoin
  #join: metadataList  {
  #  relationship: one_to_many
  #  #sql: LEFT JOIN UNNEST(${meta}) ;;
  #  sql: LEFT JOIN UNNEST(${data_series_discrete.metadata_json_kv}) as metadataList ;;
  #  #sql: LEFT JOIN UNNEST(${data_series_discrete.metadata_kv}) as metadataList ;;
  #}

  join: payloadList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_discrete.payload_json_kv}) as payloadList ;;
  }
}


explore: data_series_continuous {
  view_name: data_series_continuous
  label: "Data Series - Continuous"

  sql_always_where: ${data_series_continuous.timestamp_event_start_raw} between {% date_start data_series_continuous.timeinterval_filter %} and {% date_end data_series_continuous.timeinterval_filter %} ;;

  conditionally_filter: {
    filters: [data_series_continuous.timeinterval_filter: "4 hours "]
    unless: [data_series_continuous.timestamp_event_start_date,data_series_continuous.timestamp_event_start_time,data_series_continuous.timestamp_event_start_raw]
  }

  join: meta {
    from: meta
    sql_on: ${data_series_continuous.tag_name}=${meta.tag_name} ;;
    relationship: many_to_one
  }
  join: meta_attribute{
    required_joins: [meta]
    sql: LEFT JOIN UNNEST( meta.metadata_attributes) as meta_attribute ;;
    relationship: one_to_many
  }

  join: qualifiersList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_continuous.qualifier_kv}) as qualifiersList ;;
  }

  # This additional join allows to pivot the metadata values over the metadataKey
  # In the scenario using the CloudSQL federation - the functionality comes with the metajoin
  #join: metadataList  {
  #  relationship: one_to_many
  #  #sql: LEFT JOIN UNNEST(${meta}) ;;
  #  sql: LEFT JOIN UNNEST(${data_series_continuous.metadata_json_kv}) as metadataList ;;
  #  #sql: LEFT JOIN UNNEST(${data_series_continuous.metadata_kv}) as metadataList ;;
  #}

  join: payloadList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_continuous.payload_json_kv}) as payloadList ;;
  }
}

explore: data_series_component {
  view_name: data_series_component
  label: "Data Series - Component"
  sql_always_where: ${data_series_component.timestamp_event_raw} between {% date_start data_series_component.timeinterval_filter %} and {% date_end data_series_component.timeinterval_filter %} ;;

  conditionally_filter: {
    filters: [data_series_component.timeinterval_filter: "4 hours "]
    unless: [data_series_component.timestamp_event_date,data_series_component.timestamp_event_time,data_series_component.timestamp_event_raw]
  }

  join: meta {
    from: meta
    sql_on: ${data_series_component.tag_name}=${meta.tag_name} ;;
    relationship: many_to_one
  }
  join: meta_attribute{
    required_joins: [meta]
    sql: LEFT JOIN UNNEST( meta.metadata_attributes) as meta_attribute ;;
    relationship: one_to_many
  }

  join: qualifiersList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_component.qualifier_kv}) as qualifiersList ;;
  }

  # This additional join allows to pivot the metadata values over the metadataKey
  # In the scenario using the CloudSQL federation - the functionality comes with the metajoin
  #join: metadataList  {
  #  relationship: one_to_many
  #  #sql: LEFT JOIN UNNEST(${meta}) ;;
  #  sql: LEFT JOIN UNNEST(${data_series_component.metadata_json_kv}) as metadataList ;;
  #  #sql: LEFT JOIN UNNEST(${data_series_component.metadata_kv}) as metadataList ;;
  #}

  join: payloadList  {
    relationship: one_to_many
    sql: LEFT JOIN UNNEST(${data_series_component.payload_json_kv}) as payloadList ;;
  }
}


explore: meta {
  label: "Tag configuration with Metadata attributes"
  join: meta_attribute{
    view_label: "Metadata"
    sql: LEFT JOIN UNNEST( meta.metadata_attributes) as meta_attribute ;;
    relationship: one_to_many
  }
}
