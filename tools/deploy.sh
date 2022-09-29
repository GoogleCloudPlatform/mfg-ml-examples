#!/usr/bin/env bash
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


# Exit on error. Append "|| true" if you expect an error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
set -o pipefail

###############################################################################
# Set variables
###############################################################################
# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"

###############################################################################
# Import
###############################################################################
# shellcheck source=/dev/null
source "${__dir}/utils.sh"
# shellcheck source=/dev/null
source "${__dir}/.env"

###############################################################################
# Main
###############################################################################
print_header "Deploying Machine Learning for Manufacturing (ML4M)."

# log "Configuring MDE."
# pushd "${__dir}/../mde"
# ./configure_mde.sh --url "${MDE_CONFIG_MANAGER_URL}" \
#     --port "${MDE_CONFIG_MANAGER_PORT}"
# popd

log "Configuring MCE."
pushd "${__dir}/../mce"
./configure_mce.sh --url "${MCE_URL}" \
    --token "${MCE_API_TOKEN}" \
    --connector "${MCE_PUBSUB_CONNECTOR_ID}"
popd

print_footer "ML4M deployment completes successfully."
