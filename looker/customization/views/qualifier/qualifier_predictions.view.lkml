view: customizedqualifiers_discrete_predictions {
  fields_hidden_by_default: no
  extension: required
  view_label: "Qualifiers"

  dimension: feature_attributions_json {
    type: string
    description: "Relative value of feature importance (JSON string)"
    view_label: "Qualifiers"
    group_label: "Prediction"
    sql: JSON_QUERY(${qualifier_json}, '$.explanation.attributions[0].featureAttributions') ;;
    html:
    {% assign lines = value | remove: '{' | remove: '}' | split: ',' %}
    {% for line in lines %}
    {{ line | append: ',' }} <br>
    {% endfor %} ;;
  }

  dimension: feature_attributions_key {
    type: string
    description: "Feature attribution key from payload qualifier list"
    view_label: "Qualifiers"
    group_label: "Prediction"
    sql: IF(
      STARTS_WITH(${qualifiersList.qualifier_key}, 'explanation.attributions.0.featureAttributions.'),
      REPLACE(${qualifiersList.qualifier_key}, 'explanation.attributions.0.featureAttributions.', ''),
      NULL
    ) ;;
  }

  measure: feature_attributions_value {
    type: average
    description: "Feature attribution value from payload qualifier list"
    view_label: "Qualifiers"
    group_label: "Prediction"
    sql: CAST(${qualifiersList.qualifier_value} AS NUMERIC) ;;
    filters: [qualifiersList.qualifier_key: "explanation.attributions.0.featureAttributions.%"]
  }

  dimension: instance_json {
    type: string
    description: "Feature values for prediction (JSON string)"
    view_label: "Qualifiers"
    group_label: "Prediction"
    sql: JSON_QUERY(${qualifier_json}, '$.instance') ;;
    html:
    {% assign lines = value | remove: '{' | remove: '}' | split: ',' %}
    {% for line in lines %}
    {{ line | append: ',' }} <br>
    {% endfor %} ;;
  }


  dimension: prediction_json {
    type: string
    description: "Full prediction result from AutoML (JSON string)"
    view_label: "Qualifiers"
    group_label: "Prediction"
    sql: JSON_QUERY(${qualifier_json}, '$.prediction') ;;
    html:
    {% assign lines = value | remove: '{' | remove: '}' | split: ',' %}
    {% for line in lines %}
      {{ line | append: ',' }} <br>
    {% endfor %} ;;
  }

  dimension: actual_tool_condition {
    type: string
    description: "Actual tool condition"
    view_label: "Qualifiers"
    sql: JSON_VALUE(${qualifier_json}, '$.instance.tool_condition') ;;
    html: {% if value  == "worn" %}
    <span style="background: red; color: white; border-radius: 4px; padding: 0.1em 0;  display: block; text-align: center;"> {{value}} </span>
    {% elsif value  == "unworn" %}
    <span style="background: green; color: white; border-radius: 4px; padding: 0.1em 0;  display: block; text-align: center;"> {{value}} </span>
    {% else %}
    <span style="border-radius: 4px; padding: 0.4em 0;  display: block; text-align: center;"> {{value}} </span>
    {% endif %};;
  }

  dimension: actual_tool_condition_numeric {
    hidden: yes
    type: number
    description: "Actual tool condition in numeric representation (0 = unworn, 1 = worn)"
    view_label: "Qualifiers"
    sql: CASE ${actual_tool_condition}
    WHEN 'worn' THEN 1
    WHEN 'unworn' THEN 0
    ELSE NULL
    END ;;
  }

  measure: actual_tool_condition_numeric_max {
    type: max
    description: "Actual tool condition in numeric representation (0 = unworn, 1 = worn)"
    view_label: "Qualifiers"
    label: "Actual Tool Condition Numeric"
    sql: ${actual_tool_condition_numeric};;
  }
}
