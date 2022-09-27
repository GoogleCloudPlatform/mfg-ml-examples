view: meta_common{
  view_label: "View Config Metadata"
  extension: required

  dimension: tag_id {
    primary_key: yes
  }

  dimension: tag_name{}

  dimension: archetypeName{}

  dimension: typeName{}

  dimension: metadata_attributes{
    hidden: yes
  }
}

view: meta_attribute{
  view_label: "View Config Metadata"

  dimension: type_to_schema_id { primary_key:yes}

  dimension: bucket_name {}

  dimension: schema_id {}

  dimension: schema_name {}

  dimension: schema_description {}

  dimension: schema_attr_name {}

  dimension: schema_attr_description {}

  dimension: schema_attr_type {}

  dimension: metadata_JSON_single_bucket {}

  dimension: tag_id {}

  dimension: tag_id_key {}

  dimension: metadatakey {
    label: "Meta Attribute"
  }

  dimension: metadatavalue {}

  measure: metadata_values {
    label: "Meta Value"
    sql:  STRING_AGG(DISTINCT ${metadatavalue})  ;;
  }
}
