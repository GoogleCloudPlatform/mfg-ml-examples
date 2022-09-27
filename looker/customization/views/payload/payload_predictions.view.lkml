view: customizedpayload_discrete_predictions {
  fields_hidden_by_default: no
  extension: required
  view_label: "Payload"

  filter: score_threshold {
    type: number
    description: "Score threshold for returning the positive class prediction"
    view_label: "Payload"
  }

  dimension: positive_class {
    hidden: yes
    type: string
    description: "Positive class label"
    view_label: "Payload"
    group_label: "Prediction"
    sql: 'worn' ;;
  }

  dimension: negative_class {
    hidden: yes
    type: string
    description: "Negative class label"
    view_label: "Payload"
    group_label: "Prediction"
    sql: 'unworn' ;;
  }

  dimension: predictions {
    hidden: yes
    type: string
    description: "Prediction list of classes and scores"
    view_label: "Payload"
    group_label: "Prediction"
    sql: JSON_EXTRACT_ARRAY(${payload_json}, '$.predictions') ;;
  }

  dimension: prediction {
    hidden: yes
    type: string
    description: "Output prediction based on score thresdhold"
    view_label: "Payload"
    group_label: "Prediction"
    sql: IFNULL(
          {% if data_series_discrete.score_threshold._is_filtered %}
            (SELECT p FROM UNNEST(${predictions}) p
          WHERE JSON_VALUE(p, '$.class') = ${positive_class} AND {% condition score_threshold %}CAST(JSON_VALUE(p, '$.score') AS NUMERIC){% endcondition %}),
          {% else %}
            (SELECT p FROM UNNEST(${predictions}) p
          WHERE JSON_VALUE(p, '$.class') = ${positive_class} AND CAST(JSON_VALUE(p, '$.score') AS NUMERIC) > 0.5),
          {% endif %}
          (SELECT p FROM UNNEST(${predictions}) p
          WHERE JSON_VALUE(p, '$.class') = ${negative_class})
        ) ;;
  }

  dimension: predicted_tool_condition {
    type: string
    description: "Predicted tool condition class"
    view_label: "Payload"
    group_label: "Prediction"
    sql: JSON_VALUE(${prediction}, '$.class') ;;
    html: {% if value  == "worn" %}
    <span style="background: red; color: white; border-radius: 4px; padding: 0.1em 0;  display: block; text-align: center;"> {{value}} </span>
    {% elsif value  == "unworn" %}
    <span style="background: green; color: white; border-radius: 4px; padding: 0.1em 0;  display: block; text-align: center;"> {{value}} </span>
    {% else %}
    <span style="border-radius: 4px; padding: 0.4em 0;  display: block; text-align: center;"> {{value}} </span>
    {% endif %};;
    suggestable: yes
  }

  dimension: predicted_tool_condition_numeric {
    hidden: yes
    type: number
    description: "Predicted tool condition in numeric representation (0 = unworn, 1 = worn)"
    view_label: "Payload"
    group_label: "Prediction"
    sql: CASE ${predicted_tool_condition}
          WHEN 'worn' THEN 1
          WHEN 'unworn' THEN 0
          ELSE NULL
          END ;;
  }

  measure: predicted_tool_condition_numeric_agg {
    type: median
    description: "Predicted tool condition in numeric representation (0 = unworn, 1 = worn)"
    view_label: "Payload"
    group_label: "Prediction"
    label: "Predicted Tool Condition Numeric"
    sql: ${predicted_tool_condition_numeric} ;;
  }

  dimension: score {
    type: number
    view_label: "Payload"
    group_label: "Prediction"
    sql: CAST(JSON_VALUE(${prediction}, '$.score') AS NUMERIC) ;;
  }

  ############################################################
  # ML4MFG demo fields
  ############################################################

  dimension: supplier {
    type: string
    description: "Equipment supplier"
    sql: 'Cymbal Mill Manufacturing' ;;
  }

  # measure: worn_prediction_count_today {
  #   hidden: yes
  #   type: count
  #   description: "Worn prediction count today"
  #   view_label: "Payload"
  #   group_label: "Prediction"
  #   sql: ${predicted_tool_condition} ;;
  #   filters: [
  #     predicted_tool_condition: "worn",
  #     data_series_discrete.timestamp_event_time: "today"
  #   ]
  # }

  ############################################################
  # Actions
  ############################################################

  dimension: action_contact_supplier {
    # Action field for AD4MFG demo
    type: string
    label: "Action: Contact Supplier"
    view_label: "Payload"
    group_label: "Actions"
    group_item_label: "Contact Supplier"
    description: "Contact Supplier"
    sql: 'Contact Supplier' ;;
    html: <p><img src="https://findicons.com/files/icons/756/ginux/64/e_mail.png" height=20 width=20>{{ linked_value }}</p> ;;
    action: {
      label: "Contact Supplier"
      url: "https://looker-action-success-dklqjpm46a-uc.a.run.app"
      form_param: {
        name: "message"
        type: textarea
        label: "Message"
        required: yes
        description: "Message to Supplier"
        default: "Hi {{ data_series_discrete.supplier._value }},

<<include your message>>

Thanks,
Cymbal Materials"
      }
    }
  }

  dimension: action_schedule_maintenance {
    type: string
    label: "Action: Schedule Maintenance"
    view_label: "Payload"
    group_label: "Actions"
    group_item_label: "Schedule Maintenance"
    description: "Schedule Maintenance"
    sql: 'Schedule Maintenance' ;;
    html: <p><img src="https://findicons.com/files/icons/756/ginux/64/administrative_tools.png" height=20 width=20>{{ linked_value }}</p> ;;
    action: {
      label: "Schedule Maintenance"
      url: "https://looker-action-success-dklqjpm46a-uc.a.run.app"
      form_param: {
        name: "start_date"
        type: string
        label: "Start Date (MM-dd-YYYY)"
        required: yes
        description: "Maintenance start date. Format: MM-dd-YYYY."
      }
      form_param: {
        name: "start_time"
        type: string
        label: "Start Time (HH:mm)"
        required: yes
        description: "Maintenance start time. Format: HH:mm. 24-hour format."
      }
      form_param: {
        name: "end_date"
        type: string
        label: "End Date (MM-dd-YYYY)"
        required: yes
        description: "Maintenance end date. Format: MM-dd-YYYY."
      }
      form_param: {
        name: "end_time"
        type: string
        label: "End Time (HH:mm)"
        required: yes
        description: "Maintenance end time. Format: HH:mm. 24-hour format."
      }
      form_param: {
        name: "detail"
        type: textarea
        label: "Detail"
        required: yes
        description: "Maintenance detail"
        default: "Reasons: <<include the reasons of maintenance>>

Details:
- Equipment type: {{ meta.asset_equipmentType._value }}
- Equipment ID: {{ meta.asset_equipmentId._value }}
- Supplier: {{ data_series_discrete.supplier._value }}"
      }
    }
  }
}
