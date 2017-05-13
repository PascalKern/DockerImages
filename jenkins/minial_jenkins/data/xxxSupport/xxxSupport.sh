#!/usr/bin/env sh

set -e
# set -o

# From: http://stackoverflow.com/a/8811800
# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
function contains( ) {
    string="$1"
    substring="$2"
    # echo "String: $string, substring: $substring"
    if  [[ "${string#*$substring}" != "$string" ]]; then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

function configureAlpine ( ) {
    echo "Building on Alpine (busybox) Linux-Base!"
    export SUPPORT_BASE=/usr/local/share/alpineSupport
    source $SUPPORT_BASE/functions.sh
}

function configureOther ( ) {
    echo "Building on ... Linux-Base"
    export SUPPORT_BASE=/usr/local/share/...Support
    source $SUPPORT_BASE/functions.sh  
}

function evaluateBase ( ) {
    contains "$(cat /etc/issue)" "Alpine" && configureAlpine && return $? #exit $?
    contains "$(cat /etc/issue)" "..." && configureOther && return $? #exit $?
    echo "Could not determine the running Linux distro! uname = $(uname -a), issue = $(cat /etc/issue)"
    exit -1    
}
