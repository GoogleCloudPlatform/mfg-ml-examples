view: data_series_common {
  extension: required

  filter: timeinterval_filter {
    label: "Time window filter"
    type: date_time
    default_value: "24 hours"
  }

  measure: timeinterval_duration_sec {
    hidden: yes
    description: "Duration of filter internval in seconds. Useful for computation of measurements/time."
    type:  number
    sql: timestamp_diff({% date_end timeinterval_filter %},{% date_start timeinterval_filter %},SECOND) ;;
  }

  measure: timeinterval_duration_min {
    hidden: yes
    description: "Duration of filter internval in minutes. Useful for computation of measurements/time."
    type:  number
    sql: ${timeinterval_duration_sec}/60 ;;
  }

  measure: timeinterval_duration_hours {
    hidden: yes
    description: "Duration of filter internval in hours. Useful for computation of measurements/time."
    type:  number
    sql: ${timeinterval_duration_sec}/60/60 ;;
  }

  measure: timeinterval_duration_days {
    hidden: yes
    description: "Duration of filter internval in days. Useful for computation of measurements/time."
    type:  number
    sql: ${timeinterval_duration_sec}/60/60/24 ;;
  }

  dimension: tag_name_edge {
    description: "Tag Name Edge - Sensor name"
    type: string
    sql: ${TABLE}.cloudTagName ;;
    suggestable: yes
  }

  dimension: tag_name {
    description: "Tag Name - Unique name of the physical or logical sensor/actuator/level"
    suggestable: yes
    suggest_explore: meta
    suggest_dimension: meta.tag_name
    type: string
    sql: ${TABLE}.tagName ;;
  }

  dimension: message_id {
    description: "Message identifier"
    type: string
    sql: ${TABLE}.messageId ;;
    suggestable: yes
  }

  dimension: metadata_kv {
    hidden: yes
    description: "Metadata payload as key-value pairs"
    type: string
  }

  dimension: metadata_json {
    description: "Metadata payload in JSON string format. Value is filled if MDE setting: Storage/FlatSchema has been set"
    type: string
    sql: TO_JSON_STRING(${TABLE}.metadata) ;;
  }

  dimension: metadata_json_kv {
    hidden: yes
    description: "Metadata payload in JSON format. Value is filled if MDE setting: Storage/FlatSchema has been set"
    sql: (select ARRAY(select as struct  REPLACE(SPLIT(pq, ':')[OFFSET(0)], '"', '') metadataKey,REPLACE(SPLIT(pq, ':')[OFFSET(1)], '"', '') metadataValue
      from UNNEST(REGEXP_EXTRACT_ALL(${metadata_json},r'\"[\w\d\.\-_]+\":\"?[[:alnum:][:space:]\.\(\)\[\]?\'\!#$%&()*\+\-/:;<=>?@[\\\]^_`|~]+?')) pq )) ;;
  }

  dimension: qualifier_json {
    description: "Payload qualifier in JSON string format"
    type: string
    sql: TO_JSON_STRING(${TABLE}.payloadQualifier) ;;
  }

  dimension: qualifier_kv {
    hidden: yes
    description: "Payload qualifier as key-value pairs"
    sql:  (select ARRAY(select as struct key as qualifierKey,value as qualifierValue from UNNEST(${TABLE}.payloadQualifierKV) pq));;
  }

  dimension: qualifier_json_kv {
    hidden: yes
    description: "Payload qualifier in JSON format"
    sql: (select ARRAY(select as struct 'qualifier.' || REPLACE(SPLIT(pq, ':')[OFFSET(0)], '"', '') qualifierKey,REPLACE(SPLIT(pq, ':')[OFFSET(1)], '"', '') qualifierValue
      from UNNEST(REGEXP_EXTRACT_ALL(${qualifier_json},r'\"[\w\d\.\-_]+\":\"?[[:alnum:][:space:]\.\(\)\[\]?\'\!#$%&()*\+\-/:;<=>?@[\\\]^_`|~]+?')) pq )) ;;
  }

  dimension: payload_kv {
    hidden: yes
    description: "Payload as key-value pairs"
    sql:  (select ARRAY(select as struct key as payloadKey,value as payloadValue from UNNEST(${TABLE}.payloadKV) pq));;
  }

  dimension: payload_json {
    description: "Payload in JSON string format"
    sql: TO_JSON_STRING(${TABLE}.payload);;
  }

  dimension: payload_json_kv {
    hidden: yes
    description: "Payload in JSON format"
    sql: (select ARRAY(select as struct REPLACE(SPLIT(pq, ':')[OFFSET(0)], '"', '') payloadKey,REPLACE(SPLIT(pq, ':')[OFFSET(1)], '"', '') payloadValue
      from UNNEST(REGEXP_EXTRACT_ALL(${payload_json},r'\"[\w\d\.\-_]+\":\"?[[:alnum:][:space:]\.\(\)\[\]?\'\!#$%&()*\+\-/:;<=>?@[\\\]^_`|~]+?')) pq )) ;;
  }

  dimension: value_Decimal_4 {
    description: "Numerical value of the data series record, rounded to 4 digits after comma."
    type: number
    value_format_name: decimal_4
    sql: ${value} ;;
  }

  measure: value_last_reading {
    description: "Returns the latest value the aggregated data series records ."
    type: number
    value_format_name: decimal_2
    sql: ARRAY_AGG(${value} ORDER BY eventTimestamp DESC)[SAFE_OFFSET(0)] ;;
  }

  measure: value_min {
    description: "Min of numerical value of the data series records."
    type: min
    value_format_name: decimal_2
    sql: ${value} ;;
  }
  measure: value_max {
    description: "Max of numerical value of the data series records."
    type: max
    value_format_name: decimal_2
    sql: ${value} ;;
  }
  measure: value_avg {
    description: "Avg of numerical value of the data series records."
    type: average
    value_format_name: decimal_4
    sql: ${value} ;;
  }
  measure: value_median {
    description: "Median of numerical value of the data series records."
    type: median
    value_format_name: decimal_4
    sql: ${value} ;;
  }
  measure: value_standardDeviation {
    description: "Standard Deviation of numerical value of the data series records."
    type: number
    value_format_name: decimal_4
    sql: STDDEV_SAMP(${value}) ;;
  }

  dimension_group: timestamp_ingestion {
    description: "Timestamp set by the Data pipelines at the end of processing, just before writing data to the storage."
    type: time
    timeframes: [
      raw,
      second,
      millisecond,
      time,
      minute,
      minute5,
      minute10,
      minute15,
      minute30,
      hour,
      hour4,
      hour8,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.ingestTimestamp ;;
  }

  measure: last_data_received_at{
    label: "Newest Timestamp of incomming message"
    description: "Latest ingetion timestamp at given aggregation level"
    type: date_time
    sql: max(${TABLE}.ingestTimestamp) ;;
  }
  measure: last_data_processed_at{
    label: "Newest Timestamp of processed message"
    description: "Latest ingetion timestamp at given aggregation level"
    type: date_time
    sql: max(${TABLE}.ingestTimestamp) ;;
  }

  measure: first_data_received_at{
    description: "Oldest Timestamp of incomming message"
    type: date_time
    hidden: yes
    sql: min(${TABLE}.ingestTimestamp) ;;
  }

  measure: ingestionrate_per_second{
    description: "Ingetion rate (device timestamp) per second at given aggreation level"
    type:  number
    value_format_name: decimal_1
    sql: ${counter_records_total}/NullIf(timestamp_diff(max(${TABLE}.ingestTimestamp), min(${TABLE}.ingestTimestamp), SECOND),0) ;;
  }
  measure: ingestionrate_per_minute{
    description: "Ingetion rate (device timestamp) per second at given aggreation level"
    type:  number
    value_format_name: decimal_1
    sql: ${counter_records_total}/NullIf(timestamp_diff(max(${TABLE}.ingestTimestamp), min(${TABLE}.ingestTimestamp), MINUTE),0) ;;
  }

  measure: counter_records_total {
    description: "Amount of data series records at given aggregation level"
    type: count
    drill_fields: [tag_name]
  }
# depends on minutes_ingestion_freshness defined in the _timestamp and _timeinterval views


 }


view: data_series_common_timestamp {
  extends: [data_series_common]
  extension: required

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${tag_name},${timestamp_event_time},${timestamp_ingestion_time}) ;;
  }

  dimension_group: timestamp_event {
    description: "Timestamp of the event provided by device or gateway"
    type: time
    timeframes: [
      raw,
      second,
      millisecond,
      time,
      minute,
      minute5,
      minute10,
      minute15,
      minute30,
      hour,
      hour4,
      hour8,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.eventTimestamp ;;
  }
  measure: timestamp_event_max {
    description: "Max of Timestamp of the event provided by device or gateway at given aggregation level"
    type: max
    sql: ${timestamp_event_time};;
  }
  measure: timestamp_event_min {
    description: "Min of Timestamp of the event provided by device or gateway at given aggregation level"
    type: min
    sql: ${timestamp_event_time};;
  }

  dimension_group: ingestion_freshness {
    hidden: yes
    description: "Duration between event generation and storing processed event in database"
    type: duration
    timeframes: [
      raw,
      time,
      minute,
      millisecond,
      second,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql_end: ${TABLE}.ingestTimestamp ;;
    sql_start: ${TABLE}.eventTimestamp ;;
  }

  measure: ingestion_freshness_avg_seconds {
    description: "Average of duration between event generation and storing processed event in database"
    sql: ${seconds_ingestion_freshness} ;;
    type: average
    value_format_name: decimal_2
  }

  measure: ingestionrate_byEventTime_per_second{
    description: "Event rate (processing timestamp) per second at given aggreation level"
    type:  number
    value_format_name: decimal_1
    sql: ${counter_records_total}/NullIf(timestamp_diff(max(${TABLE}.eventTimestamp), min(${TABLE}.eventTimestamp), SECOND),0) ;;
  }
}


view: data_series_common_interval {
  extends: [data_series_common]
  extension: required

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(${tag_name},${timestamp_event_start_time},${timestamp_event_end_time},${timestamp_ingestion_time}) ;;

  }

  dimension_group: timestamp_event_end {
    type: time
    timeframes: [
      raw,
      time,
      minute,
      minute5,
      minute10,
      minute15,
      minute30,
      hour,
      hour4,
      hour8,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.eventTimestampEnd ;;
  }

  dimension_group: timestamp_event_start {
    type: time
    timeframes: [
      raw,
      time,
      minute,
      minute5,
      minute10,
      minute15,
      minute30,
      hour,
      hour4,
      hour8,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.eventTimestampStart ;;
  }

  dimension_group: ingestion_freshness {
    description: "Computes the amout of time between the timestamp of event generation and storing processed event"
    type: duration
    timeframes: [
      raw,
      time,
      minute,
      hour,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql_end: ${TABLE}.ingestTimestamp ;;
    sql_start: ${TABLE}.eventTimestampEnd ;;
  }

  dimension: event_interval_duration {
    type: number
    sql: TIMESTAMP_DIFF(${TABLE}.eventTimestampEnd, ${TABLE}.eventTimestampStart, second) ;;
  }

  measure: ingestionrate_byEventTime_per_second{
    description: "From interval closing event Timestamp"
    type:  number
    value_format_name: decimal_1
    sql: ${counter_records_total}/NullIf(timestamp_diff(max(${TABLE}.eventTimestampEnd), min(${TABLE}.eventTimestampEnd), SECOND),0) ;;
  }
}
