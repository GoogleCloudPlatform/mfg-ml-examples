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
MCE_URL='https://localhost'                                    # format: 'https://<ip-or-dns>'
MCE_API_TOKEN='aGVsbG93b3JsZDo='                               # base64 encoded MCe API key + ':'
MCE_PUBSUB_CONNECTOR_ID='11111111-aaaa-2222-bbbb-333333333333' # MCe pub/sub connector id

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
    echo "Usage: configure_mce [ -c | --connector ]
               [ -t | --token ]
               [ -u | --url   ]
               [ -h | --help  ]"
    exit 2
}

# START callMCeDeviceHubAPI
function callMCeDeviceHubAPI() {
    log "******** ${1} configuration ********"
    createCounter=0
    for FILE in "${__dir}/${2}"/*.json; do
        createCounter=$((createCounter + 1))
        # echo "@${FILE}"
        log "File #${createCounter}: ${FILE}" '5'
        curl -L -X POST "${MCE_URL}${3}" \
            -H 'Content-Type: application/json' \
            -H "Authorization: Basic ${MCE_API_TOKEN}" \
            -d "@${FILE}" \
            --post301 \
            -k
        log "File #${createCounter} DONE" '5'
    done
    log "******** ${1} configuration DONE ********\n"
}
# END callMCeDeviceHubAPI

# START callMCeDeviceHubAPINoPayload
function callMCeDeviceHubAPINoPayload() {
    log "******** ${1} ********"
    curl -L -X "${2}" "${MCE_URL}${3}" \
        -H 'Content-Type: application/json' \
        -H "Authorization: Basic ${MCE_API_TOKEN}" \
        -k
    log "******** ${1} DONE ********\n"
}
# END callMCeDeviceHubAPINoPayload

###############################################################################
# Argument Parsing
###############################################################################
while :; do
    case "$1" in
    -c | --connector)
        MCE_PUBSUB_CONNECTOR_ID="$2"
        shift
        shift
        ;;
    -t | --token)
        MCE_API_TOKEN="$2"
        shift
        shift
        ;;
    -u | --url)
        MCE_URL="$2"
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
# Let the user know what we end up calling
log "Using URL: ${MCE_URL}"

callMCeDeviceHubAPINoPayload "STOP CONNECTOR" "PUT" "/cc/instances/${MCE_PUBSUB_CONNECTOR_ID}/disable"
callMCeDeviceHubAPI "CONNECTORS" "connectors" "/cc/instances/${MCE_PUBSUB_CONNECTOR_ID}/createSubs"
callMCeDeviceHubAPINoPayload "START CONNECTOR" "PUT" "/cc/instances/${MCE_PUBSUB_CONNECTOR_ID}/enable"
