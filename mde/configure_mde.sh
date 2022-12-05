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

###############################################################################
# Variables
###############################################################################
# Default values for variables
MDE_CONFIG_MANAGER_URL='http://localhost' # format: 'http://<ip-or-dns>'
MDE_CONFIG_MANAGER_PORT='8080'            # format: [0-65536]

# Set magic variables for current file, directory, os, etc.
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__file="${__dir}/$(basename "${BASH_SOURCE[0]}")"
__base="$(basename "${__file}" .sh)"

###############################################################################
# Import
###############################################################################
# shellcheck source=/dev/null
source "${__dir}/../tools/utils.sh"

###############################################################################
# Functions
###############################################################################
help() {
    echo "Usage: configure_mde [ -p | --port ]
               [ -u | --url   ]
               [ -h | --help  ]"
    exit 2
}

# START callConfigManagerAPI
function callConfigManagerAPI() {
    log "******** ${1} configuration ********"
    createCounter=0
    for FILE in "${__dir}/${2}"/*; do
        createCounter=$((createCounter + 1))
        log "File #${createCounter}: ${FILE}" '5'
        curl -X POST "${MDE_CONFIG_MANAGER_URL}:${MDE_CONFIG_MANAGER_PORT}/api/v1${3}" \
            -H 'Content-Type: application/json' \
            -H "Accept:application/json" \
            -d "@${FILE}"
        log "File #${createCounter} DONE" '5'
    done
    log "******** ${1} configuration DONE ********\n"
}
# END callConfigManagerAPI

###############################################################################
# Argument Parsing
###############################################################################
while :; do
    case "$1" in
    -p | --port)
        MDE_CONFIG_MANAGER_PORT="$2"
        shift
        shift
        ;;
    -u | --url)
        MDE_CONFIG_MANAGER_URL="$2"
        shift
        shift
        ;;
    -h | --help)
        help
        exit
        ;;
    --)
        shift
        break
        ;;
    '') # end of options
        break
        ;;
    *)
        echo "Unexpected option: $1"
        help
        ;;
    esac
done

###############################################################################
# Main
###############################################################################
log "Using URL: ${MDE_CONFIG_MANAGER_URL} on port: ${MDE_CONFIG_MANAGER_PORT}"

callConfigManagerAPI "TYPES" "types" "/types"
callConfigManagerAPI "BUCKETS" "buckets" "/metadata/bucket"
callConfigManagerAPI "SCHEMAS" "schemas" "/schema"
callConfigManagerAPI "SCHEMAS TO BUCKETS" "schema_to_buckets" "/metadata/bucket/schema"
callConfigManagerAPI "INGESTIONS" "ingestions" "/ingestions"
callConfigManagerAPI "PAYLOADS" "payloads" "/payloads"
callConfigManagerAPI "PARSERS" "parsers" "/pipelines"
callConfigManagerAPI "TAGS" "tags" "/tags"

# START customer logic for metadata instances
log "******** METATDATA VALUE TO TAGS configuration ********"
createCounter=0
for FILE in "${__dir}/metadata_instances"/*; do
    createCounter=$((createCounter + 1))
    log "File #${createCounter}: ${FILE}" '5'
    filename=$(basename "${FILE}")
    IFS='.' read -r -a tagname <<<"${filename}"
    curl -X POST "${MDE_CONFIG_MANAGER_URL}:${MDE_CONFIG_MANAGER_PORT}/api/v1/tags/${tagname[0]}/metadata" \
        -H 'Content-Type: application/json' \
        -H "Accept:application/json" \
        -d "@${FILE}"

    log "File #${createCounter} DONE" '5'
done
log "******** ${1} configuration DONE ********\n"
# END customer logic for metadata instances
