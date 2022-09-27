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
  value: "mde-ml-dev"
}

# LookML project identifier, as defined in "Develop->Manage LookML projects->Project"
constant: looker_projectid {
  value: "mde-ml"
}

# Descriptive name for the LookML project, to be used in Name definition of explore's
constant: looker_projectName {
  value: "MDE ML Dev"
}

# URL of the current Looker instance, used for creation of dashboard links
constant: looker_instance_link {
  value: "https://imde.cloud.looker.com"
}

# Defines interval to rebuild cache for data series queries
# synchronized from config manager
constant: default_cache_refresh {
  # recommended to keep it between 1- 30 minutes
  value: "2 minutes"
}

# Defines interval to rebuild cache tables holding the Metadata and TagConfiguration information
# synchronized from config manager
constant: pde_refresh {
  # recommended to keep it between 10-60 minutes
  value: "10 minutes"
}

constant: operationalRanges_refresh {
  # recommended 5 minutes for bigtable and cloudSQL and 1h for flat schema
  value: "24 hour"
}

# Defines the backend storage for MDE Config Manager component
# The LookML model is using the data for optimization of tag-selection and metadata handling
constant: gcp_imde_configmgmt_storagetype {
  # the default MDE configuration backend is cloudSQL, the bigtable is an second option
  # For both types of Config Management backend, an federation between BigQuery and the ConfigMgmt-DB
  # need to be setup prior the usage
  # For instances where setup of the federation links isn't possible because of org policies
  # the option flatschema can be used in combination with flatSchema=true
  # configured at tag level

  # cloudsql, bigtable or flatschema
  value: "cloudsql"
}

# Only applies for option: gcp_imde_configmgmt_storagetype: flatschema
#
# defines if the metadata/qualifiers values will be extracted from
# JSON or NestedRepeated record-columns at SQL level
constant: gcp_imde_meta_storagetype {
  # json or kv
  value: "json"
}

# only applies for option: gcp_imde_configmgmt_storagetype: cloudsql
constant: gcp_cloudsqllink {
  # Defines the
  value: "projects/mde-ml-dev-01/locations/us/connections/imde-cfg-sql"
}
