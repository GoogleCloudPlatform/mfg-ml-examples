view: metadata_cncmilling {
  extension: required
  label: "Metadata CNC milling"
  view_label: "Metadata"

  dimension: organization_companyId {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Company Id"
    description: "Company Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "companyId" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_company {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Company"
    description: "Company"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "company" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_plantId {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Plant Id"
    description: "Plant Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "plantId" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_plant {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Plant"
    description: "Plant"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "plant" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_city {
    view_label: "Metadata"
    group_label: "Organization"
    label: "City"
    description: "City"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "city" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_address {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Address"
    description: "Address"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "address" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_federalState {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Federal State"
    description: "Federal State"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "federalState" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_country {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Country"
    description: "Country"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "country" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_departmentId {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Department Id"
    description: "Department Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "departmentId" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_department {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Department"
    description: "Department"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "department" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_lineId {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Line Id"
    description: "Line Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "lineId" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_line {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Line"
    description: "Line"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "line" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_processId {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Process Id"
    description: "Process Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "processId" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_process {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Process"
    description: "Process"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "process" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_stationId {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Station Id"
    description: "Station Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "stationId" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: organization_station {
    view_label: "Metadata"
    group_label: "Organization"
    label: "Station"
    description: "Station"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "station" and bucket_name="cncmill" and schema_id="organization") ;;
  }

  dimension: asset_equipmentLocation {
    view_label: "Metadata"
    group_label: "Asset"
    label: "Equipment Location"
    description: "Equipment Location"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "equipmentLocation" and bucket_name="cncmill" and schema_id="asset") ;;
  }

  dimension: asset_equipmentId {
    view_label: "Metadata"
    group_label: "Asset"
    label: "Equipment Id"
    description: "Equipment Id"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "equipmentId" and bucket_name="cncmill" and schema_id="asset") ;;
  }

  dimension: asset_equipment {
    view_label: "Metadata"
    group_label: "Asset"
    label: "Equipment"
    description: "Equipment"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "equipment" and bucket_name="cncmill" and schema_id="asset") ;;
  }

  dimension: asset_equipmentType {
    view_label: "Metadata"
    group_label: "Asset"
    label: "Equipment Type"
    description: "Equipment Type"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "equipmentType" and bucket_name="cncmill" and schema_id="asset") ;;
  }

  dimension: cmcmill_material {
    view_label: "Metadata"
    group_label: "CNC Mill"
    label: "Material"
    description: "Material which CNC mill is operating on"
    type: string
    suggestable: yes
    sql: (SELECT metadatavalue FROM UNNEST(meta.metadata_attributes) where metadatakey = "material" and bucket_name="cncmill" and schema_id="cncmill") ;;
  }

}
