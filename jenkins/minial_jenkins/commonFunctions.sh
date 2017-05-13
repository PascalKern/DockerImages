#!/usr/bin/env bash

set -e

function log( ) {
    msg="$1"
    level="INFO"
    # if [[ $# -gt 1 ]]; then
    if [[ ! -z ${2+x} ]] && [[ ! -z "$2" ]]; then  # First check if set, second check if not empty string!
        level="$2"
    fi
    if [[ ! -z ${LOG_LEVEL+x} ]] && [[ "DEBUG" == "$LOG_LEVEL" ]]; then
        echo " DEBUG - $1"
    else
        echo " INFO  - $1"
    fi
}