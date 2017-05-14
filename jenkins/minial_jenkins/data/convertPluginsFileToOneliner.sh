#!/usr/bin/env bash

set -e

if [[ -z ${1+x} ]]; then
    echo "Please give the path to the plugins file to parse!"
    exit -1
fi

PLUGINS_PARSED="$(sed '/^$/d; /^#.*$/d' $1 | tr '\n' ' ')"

# To return value
echo $PLUGINS_PARSED

if [[ ! -z ${2+x} && "export" == "$2" ]]; then 
    echo "Exporting parsed plugin variable! (PLUGINS_PARSED = $PLUGINS_PARSED)"
    export PLUGINS_PARSED=$PLUGINS_PARSE
fi

exit 0