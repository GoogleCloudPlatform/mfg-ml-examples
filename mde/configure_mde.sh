#!/usr/bin/env bash

###############################################################################
# Variables
###############################################################################
# Default values for variables
MDE_CONFIG_MANAGER_URL='http://localhost'
MDE_CONFIG_MANAGER_PORT='8080'

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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
    printf "${GREEN}*** ${1} ***\n${NC}"
    createCounter=0
    for FILE in "${2}"/*; do
        createCounter=$((createCounter + 1))
        printf "${BLUE}File #${createCounter}: ${FILE}${NC}\n"
        curl -X POST "${MDE_CONFIG_MANAGER_URL}:${MDE_CONFIG_MANAGER_PORT}/api/v1${3}" \
            -H 'Content-Type: application/json' \
            -H "Accept:application/json" \
            -d "@${FILE}"
        printf "${BLUE}\nFile #${createCounter} DONE\n${NC}"
    done
    printf "${GREEN}*** ${1} DONE ***\n\n${NC}"
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
printf "Using URL: ${MDE_CONFIG_MANAGER_URL} on port: ${MDE_CONFIG_MANAGER_PORT}\n"

callConfigManagerAPI "TYPES" "types" "/types"
callConfigManagerAPI "BUCKETS" "buckets" "/metadata/bucket"
callConfigManagerAPI "SCHEMAS" "schemas" "/schema"
callConfigManagerAPI "SCHEMAS TO BUCKETS" "schema_to_buckets" "/metadata/bucket/schema"
callConfigManagerAPI "INGESTIONS" "ingestions" "/ingestions"
callConfigManagerAPI "PAYLOADS" "payloads" "/payloads"
callConfigManagerAPI "PARSERS" "parsers" "/pipelines"
callConfigManagerAPI "TAGS" "tags" "/tags"

# START customer logic for metadata instances
printf "${GREEN}*** METATDATA VALUE TO TAGS ***\n${NC}"
createCounter=0
for FILE in metadata_instances/*; do
    createCounter=$((createCounter + 1))
    printf "${BLUE}File #${createCounter}: ${FILE}${NC}\n"
    IFS='/' read -r -a filename <<<"${FILE}"       #remove folder
    IFS='.' read -r -a tagname <<<"${filename[1]}" #remove extension

    curl -X POST "${MDE_CONFIG_MANAGER_URL}:${MDE_CONFIG_MANAGER_PORT}/api/v1/tags/${tagname[0]}/metadata" \
        -H 'Content-Type: application/json' \
        -H "Accept:application/json" \
        -d "@${FILE}"

    printf "${BLUE}\nFile #${createCounter} DONE\n${NC}"
done
printf "${GREEN}*** ${1} DONE ***\n\n${NC}"
# END customer logic for metadata instances
