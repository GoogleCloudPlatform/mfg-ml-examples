include: "./payload/*.view"

view: customizedpayload_numeric {
  extension: required
  extends: [
    customizedpayload_generic,
    customizedpayload_numeric_cncmilling
  ]
}

view: customizedpayload_discrete {
  extension: required
  extends: [
    customizedpayload_generic,
    customizedpayload_discrete_predictions
  ]
}

view: customizedpayload_continuous {
  extension: required
  extends: [customizedpayload_generic]
}

view: customizedpayload_component {
  extension: required
  extends: [customizedpayload_generic]
}


view: customizedpayload_generic {
  # Container view for generic dimensions and measures across
  # customized data series
  fields_hidden_by_default: no
  extension: required
  view_label: "Payload - Generic"
}
