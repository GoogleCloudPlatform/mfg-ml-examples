include: "./metadata/*.view"

view: meta_custom {
  extension: required

  extends:[
    metadata_cncmilling
  ]

  label: "Metadata"
  view_label: "Metadata"
}
