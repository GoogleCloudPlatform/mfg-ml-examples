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

###############################################
# Starts measurements of time
###############################################
function start_timer() {
    if [ -z ${START_TIME+x} ]; then
        START_TIME=$(date +%s)
        export START_TIME
    fi
}

###############################################
# Stop timer and write data into the log file
###############################################
function measure_timer() {
    if [ -z ${START_TIME+x} ]; then
        MEASURED_TIME=0
        start_timer
    else
        END_TIME=$(date +%s)
        local TIMER
        TIMER=$((END_TIME - START_TIME))
        MEASURED_TIME=$(printf "%.2f\n" "${TIMER}")
    fi
}

###############################################
# Print starting headlines of the script
# Params:
#   1 - text to show
###############################################
SEPARATOR="*******************************************************************"
COLOR='\033[32m'
NORMAL='\033[0m'
function print_header() {
    start_timer
    CALLER="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
    printf "\n${COLOR}%s${NORMAL}" "${SEPARATOR}"
    printf "\n${COLOR}STARTED: %s (${CALLER})${NORMAL}" "$1"
    printf "\n${COLOR}%s${NORMAL}\n" "${SEPARATOR}"
}

###############################################
# Print closing footer of the script
###############################################
function print_footer() {
    measure_timer
    CALLER="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
    printf "\n${COLOR}%s${NORMAL}" "${SEPARATOR}"
    printf "\n${COLOR}%s${NORMAL}" "$1"
    printf "\n${COLOR}FINISHED: in %s seconds (${CALLER}).${NORMAL}" "${MEASURED_TIME}"
    printf "\n${COLOR}%s${NORMAL}\n" "${SEPARATOR}"
}

##############################################################################
# Replace standard ECHO function with custom out
# PARAMS: 1 - Text to show (mandatory)
#         2 - Logging level (optional) - see levels below
##############################################################################
# Available logging levels (least to most verbose)
ECHO_NONE="0"
ECHO_NO_PREFIX="1"
ECHO_ERROR="2"
ECHO_WARNING="3"
ECHO_INFO="4"
ECHO_DEBUG="5"
# Default logging level
ECHO_LEVEL="${ECHO_DEBUG}"
function log() {
    local RED='\033[0;31m'
    local GREEN='\033[32m'
    local YELLOW='\033[33m'
    local BLUE='\033[0;34m'
    local NORMAL='\033[0m'
    local PREFIX="${CALLER}->"

    if [ $# -gt 1 ]; then
        local ECHO_REQUESTED=$2
    else
        local ECHO_REQUESTED=${ECHO_INFO}
    fi

    if [ ${ECHO_REQUESTED} -gt ${ECHO_LEVEL} ]; then return; fi
    if [ ${ECHO_REQUESTED} = ${ECHO_NONE} ]; then return; fi
    if [ ${ECHO_REQUESTED} = ${ECHO_ERROR} ]; then PREFIX="${RED}[ERROR] ${PREFIX}"; fi
    if [ ${ECHO_REQUESTED} = ${ECHO_WARNING} ]; then PREFIX="${YELLOW}[WARNING] ${PREFIX}"; fi
    if [ ${ECHO_REQUESTED} = ${ECHO_INFO} ]; then PREFIX="${GREEN}[INFO] ${PREFIX}"; fi
    if [ ${ECHO_REQUESTED} = ${ECHO_DEBUG} ]; then PREFIX="${BLUE}[DEBUG] ${PREFIX}"; fi
    if [ ${ECHO_REQUESTED} = ${ECHO_NO_PREFIX} ]; then PREFIX="${GREEN}"; fi

    measure_timer
    printf "${PREFIX}%s ($MEASURED_TIME seconds)${NORMAL}\n" "$1"
}

#############################################
# Print an error message to stderr and exit the current script
# Arguments:
#  Message to display.
#  Error code to exit with. (optional, defult: 1). If the exit code is 0,
#  no red color or stderr is used
# Outputs:
#  Message to stderr and stdout
#############################################
die() {
    if [ -n "${2+x}" ] && [ "${2}" == "0" ]; then
        log "$1"
    else
        log "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" "${ECHO_ERROR}" >&2
    fi
    exit "${2:-1}" # exit with second parameter value (default: 1)
}
