#!/usr/bin/env sh

set -e
# set -o

function configShell( ) {
    echo "Update history controll for shell."
    cat > /etc/bashrc << EOF

# History controll
export HISTTIMEFORMAT="%h %d %H:%M:%S> "
export HISTCONTROL=ignoredups
export HISTSIZE=10000

EOF
}

# Apk usage inspired by: https://github.com/gliderlabs/docker-alpine/blob/master/docs/usage.md
function setTimeZone( ) {
    apk -q update
    apk --no-cache add tzdata
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime
    echo "Europe/Zurich" > /etc/timezone
    apk del tzdata
    rm -rf /var/cache/apk/*
}
