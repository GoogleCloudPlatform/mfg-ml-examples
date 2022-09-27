include: "../../views/dataseries/*.view"
include: "./qualifier/*.view"


view: customizedqualifiers_numeric {
  extends: [customizedqualifiers_generic]
}

view: customizedqualifiers_discrete{
  extends: [
    customizedqualifiers_generic,
    customizedqualifiers_discrete_predictions,
  ]
}

view: customizedqualifiers_continuous {
  extends: [customizedqualifiers_generic]
}

view: customizedqualifiers_component {
  extends: [customizedqualifiers_generic]
}

view: customizedqualifiers_generic {
  fields_hidden_by_default: no
  extension: required
  view_label: "Qualifiers"

  dimension: header {
    view_label: "Qualifiers"
    type: string
    sql: JSON_QUERY(${qualifier_json}, '$.headers') ;;
  }
}
