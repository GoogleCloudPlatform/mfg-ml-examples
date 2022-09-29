#!/usr/bin/env bash

###############################################################################
# Variables
###############################################################################
# Default values for variables
MCE_URL='https://localhost'                                    # format: 'https://<ip-or-dns>'
MCE_API_TOKEN='aGVsbG93b3JsZDo='                               # base64 encoded MCe API key + ':'
MCE_PUBSUB_CONNECTOR_ID='11111111-aaaa-2222-bbbb-333333333333' # MCe pub/sub connector id

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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
    printf "${GREEN}*** ${1} ***\n${NC}"
    createCounter=0
    for FILE in "${2}"/*.json; do
        createCounter=$((createCounter + 1))
        # echo "@${FILE}"
        printf "${BLUE}File #${createCounter}: ${FILE}${NC}\n"
        curl -L -X POST "${MCE_URL}${3}" \
            -H 'Content-Type: application/json' \
            -H "Authorization: Basic ${MCE_API_TOKEN}" \
            -d "@${FILE}" \
            --post301 \
            -k
        printf "${BLUE}\nFile #${createCounter} DONE\n${NC}"
    done
    printf "${GREEN}*** ${1} DONE ***\n\n${NC}"
}
# END callMCeDeviceHubAPI

# START callMCeDeviceHubAPINoPayload
function callMCeDeviceHubAPINoPayload() {
    printf "${GREEN}*** ${1} ***\n${NC}"
    curl -L -X "${2}" "${MCE_URL}${3}" \
        -H 'Content-Type: application/json' \
        -H "Authorization: Basic ${MCE_API_TOKEN}" \
        -k
    printf "${GREEN}*** ${1} DONE ***\n\n${NC}"
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
printf "Using URL: ${MCE_URL} \n"

callMCeDeviceHubAPINoPayload "STOP CONNECTOR" "PUT" "/cc/instances/${MCE_PUBSUB_CONNECTOR_ID}/disable"
callMCeDeviceHubAPI "CONNECTORS" "connectors" "/cc/instances/${MCE_PUBSUB_CONNECTOR_ID}/createSubs"
callMCeDeviceHubAPINoPayload "START CONNECTOR" "PUT" "/cc/instances/${MCE_PUBSUB_CONNECTOR_ID}/enable"
