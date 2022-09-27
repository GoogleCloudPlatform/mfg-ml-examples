include: "../../customization/views/*.view"
include: "../dataseries/data_series_common.view"


view: data_series_continuous {
  label: " Data series Continuous - @{looker_projectName}"
  extends: [
    data_series_common_interval,
    customizedtag_continuous,
    customizedqualifiers_continuous,
    customizedpayload_continuous,
    asset_state_current,
    asset_state_previous
  ]

  sql_table_name: `sfp_data.ContinuousDataSeries`  ;;

  dimension: value {
    description: "Numerical value of the data series record."
    type: number
    sql: (SELECT cast(payloadValue as BIGNUMERIC) from UNNEST(${payload_kv})  where payloadKey = "value") ;;
  }

  dimension: uptime {
    description: "Uptime"
    type: number
  }

  dimension: downtime {
    description: "Uptime"
    type: number
  }

  dimension: current_state_json {
    description: "Current state in Json format."
    type: string
    sql: ${TABLE}.currentStateJson ;;
  }

  dimension: current_state_json_kv {
    hidden: yes
    description: "Current state in Json format"
    sql: (select ARRAY(select as struct  REPLACE(SPLIT(pq, ':')[OFFSET(0)], '"', '') stateKey,REPLACE(SPLIT(pq, ':')[OFFSET(1)], '"', '') stateValue
      from UNNEST(REGEXP_EXTRACT_ALL(${current_state_json},r'\"[\w\d\.\-_]+\":\"?[[:alnum:][:space:]\.\(\)\[\]?\'\!#$%&()*\+\-/:;<=>?@[\\\]^_`|~]+?')) pq )) ;;
  }

  dimension: previous_state_json {
    description: "Current state in Json format."
    type: string
    sql: ${TABLE}.previousStateJson ;;
  }

  dimension: previous_state_json_kv {
    hidden: yes
    description: "Previous state in Json format"
    sql: (select ARRAY(select as struct  REPLACE(SPLIT(pq, ':')[OFFSET(0)], '"', '') stateKey,REPLACE(SPLIT(pq, ':')[OFFSET(1)], '"', '') stateValue
      from UNNEST(REGEXP_EXTRACT_ALL(${previous_state_json},r'\"[\w\d\.\-_]+\":\"?[[:alnum:][:space:]\.\(\)\[\]?\'\!#$%&()*\+\-/:;<=>?@[\\\]^_`|~]+?')) pq )) ;;
  }


}
