datagroup: imdeconf_cloudsql_json_datagroup {
  label: "IMDE Configuration Cache"
  max_cache_age: "@{pde_refresh}"
  sql_trigger:  select updated from EXTERNAL_QUERY("@{gcp_cloudsqllink}", "SELECT max(updated_date) updated  FROM tag_entity;") ;;
}
