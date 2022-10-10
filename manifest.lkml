# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Database connection identifier, as defined in "Admin->Database->Connection"
constant: looker_connection {
  value: "<BIGQUERY_CONNECT_NAME>"
}

# LookML project identifier, as defined in "Develop->Manage LookML projects->Project"
constant: looker_projectid {
  value: "<LOOKML_PROJECT_ID>"
}

# Descriptive name for the LookML project, to be used in explore and view labels
constant: looker_projectName {
  value: "<LOOKML_PROJECT_NAME>"
}

# URL of the current Looker instance, used for creation of dashboard links
constant: looker_instance_link {
  value: "<LOOKER_INSTANCE_URL>"
}

# Defines interval to rebuild cache for data series queries
# synchronized from config manager
constant: default_cache_refresh {
  # recommended to keep it between 1- 30 minutes
  value: "2 minutes"
}

# Defines interval to rebuild cache tables holding the metadata and
# tag configuration information synchronized from config manager
constant: pde_refresh {
  # recommended to keep it between 10-60 minutes
  value: "10 minutes"
}

constant: operationalRanges_refresh {
  # recommended 5 minutes for bigtable and cloudSQL and 1h for flat schema
  value: "24 hour"
}

# Defines the backend storage for MDE Config Manager component
# The LookML model is using Config Manager for tag selection and metadata handling
constant: gcp_imde_configmgmt_storagetype {
  # Options: `cloudsql` (default), `bigtable`, `flatschema`
  # Note: connection between BigQuery and Config Manager database is required
  # prior the usage
  # If BigQuery connection cannot be created because of org policies,
  # the option `flatschema` can be used in combination with `flatSchema=true`
  # configured at tag level

  value: "cloudsql"
}

# Only applies when `gcp_imde_configmgmt_storagetype: flatschema`
#
# Defines if the metadata/qualifiers values will be extracted from
# JSON or NestedRepeated record-columns at SQL level
constant: gcp_imde_meta_storagetype {
  # json or kv
  value: "json"
}

# only applies when `gcp_imde_configmgmt_storagetype: cloudsql`
constant: gcp_cloudsqllink {
  value: "<BIGQUERY_CLOUDSQL_CONNECTION_ID>"
}
