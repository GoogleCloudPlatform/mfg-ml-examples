# defines the skaffold structure for common attribtutes and the nested repeated stuct
include: "../../meta/meta_common.view.lkml"
include: "../../../customization/views/Metadata.view.lkml"


view: meta{
  label: "View Config Metadata"
  extends: [
    meta_common,
    meta_custom,
  ]
  derived_table:{
    sql:  CREATE TEMPORARY FUNCTION CUSTOM_JSON_EXTRACT(json STRING, json_path STRING)
RETURNS STRING
LANGUAGE js AS """
    try { var parsed = JSON.parse(json);
        return JSON.stringify(jsonPath(parsed, json_path));
    } catch (e) { returnnull }
"""
OPTIONS (
    library="gs://imde-show-temp/jsonpath-0.8.0.js"
);

select tag_meta_instance.tag_id,tag.tag_name, tag.archetypeName, tag.typeName, ARRAY_CONCAT_AGG(attr) metadata_attributes
          from (
            select tag_id, ARRAY(
               select as struct bucket_name,schema_id,schema_name,schema_description,bucket_version,instance_version,
                     attributes as metadata_JSON_single_bucket,tag_id,tag_id_key,
                     schema_attr_name, schema_attr_description, schema_attr_type
                     -- type_to_schema_id, provider_id,schema_entry_ref, tag_id
                   -- ,current_bucket_version,current_instance_version
                   ,REPLACE(SPLIT(metadata, ':')[OFFSET(0)], '"', '') metadatakey
                   ,REPLACE(SPLIT(metadata, ':')[OFFSET(1)], '"', '') metadatavalue
               from unnest((attributes_agg)) metadata
                 inner join (
                    SELECT schema_id as schema_id, name as schema_name, description as schema_description, -- value as schema_json,
                          JSON_EXTRACT_SCALAR(schema_attr_entry,"$.name") as schema_attr_name,
                          JSON_EXTRACT_SCALAR(schema_attr_entry,"$.description") as schema_attr_description,
                          JSON_EXTRACT_SCALAR(schema_attr_entry,"$.type") as schema_attr_type

                     FROM EXTERNAL_QUERY("projects/imde-show/locations/eu/connections/imde-cfg-sql",
                                         "SELECT name, description, value, cast(schema_id as VARCHAR) schema_id  FROM metadata_schema_entity;"),
                            unnest (JSON_EXTRACT_ARRAY(CUSTOM_JSON_EXTRACT(JSON_QUERY(value,('$.properties')), "$.*"),"$.") ) schema_attr_entry
                    ) mdeschema on mdeschema.schema_id = instance.schema_id and mdeschema.schema_attr_name = REPLACE(SPLIT(metadata, ':')[OFFSET(0)], '"', '') --metadatakey
      where bucket_version=current_bucket_version and current_instance_version=instance_version
      ) as attr
      from (
               SELECT id as type_to_schema_id,provider_id,bucket_name,schema_id,bucket_version,instance_version,schema_entry_ref,attributes,tag_id,tag_id_key
                      ,(REGEXP_EXTRACT_ALL((q.attributes) ,r'\"[\w\d\.\-_]+\":\"?[[:alnum:][:space:]\.\(\)\[\]?\'\!#$%&()*+\-/:;<=>?@[\\\]^_`|~]+' )) attributes_agg,
                    LAST_VALUE(bucket_version) over (PARTITION by bucket_name ORDER BY bucket_version ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as current_bucket_version,
                    LAST_VALUE(instance_version) over (PARTITION by bucket_name,bucket_version,schema_id ORDER BY bucket_name,bucket_version,schema_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as current_instance_version
               FROM EXTERNAL_QUERY("@{gcp_cloudsqllink}",
                                   "SELECT bucket_name, bucket_version,instance_version ,attributes,tag_id_key, cast(id as VARCHAR),cast(provider_id as VARCHAR),cast(schema_id as VARCHAR),cast(schema_entry_ref as VARCHAR),cast(tag_id as VARCHAR) FROM metadata_instance_entity;") q
               group by 1,2,3,4,5,6,7,8,9,10 ) instance
          ) tag_meta_instance
       inner join (
              SELECT id as tag_id, name as tag_name,archetype_name as archetypeName, type_name as typeName
                     ,bigquery,gcs,bigtable
                    --, TIMESTAMP_MILLIS(created_date) as created_date, TIMESTAMP_MILLIS(updated_date) as updated_date, TIMESTAMP_MILLIS(last_seen_date) as last_seen_date , count as apicount
                     FROM EXTERNAL_QUERY("@{gcp_cloudsqllink}",
                                         "SELECT name, archetype_name, bigquery,bigtable, gcs, type_name, cast(id as VARCHAR) , created_date, updated_date, last_seen_date, count  FROM tag_entity;")
                ) tag on tag.tag_id=tag_meta_instance.tag_id

          group by tag_meta_instance.tag_id,tag.tag_name, tag.archetypeName, tag.typeName
      ;;
    datagroup_trigger: imdeconf_cloudsql_json_datagroup
  }

}
