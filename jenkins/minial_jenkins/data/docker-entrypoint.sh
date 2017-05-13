#!/usr/bin/env sh

set -e
# set -o

if [[ -z ${1+x} ]] || [[ "$1" == "--"* ]] || [[ "$1" == "jenkins" ]]; then    #If not set first parameter OR first parameter equals "--" or jenkins
    if [[ "$1" == "--"* ]] || [[ "$1" == "jenkins" ]]; then
        echo "*************** Start jenkins... (Additional given parameters: $@)"
    else
        echo "*************** Start jenkins..."
    fi

    # exec tini -s -- /usr/local/bin/jenkins.sh &
    tini -s -- /usr/local/bin/jenkins.sh "$@" &
    # init tini -s -- /usr/local/bin/jenkins.sh &    
        
    if [[ 0 -ne $? ]]; then
        echo "Could not start jenkins! Error: $?"
        exit -1
    fi

    pluginsDir=/usr/share/jenkins/ref/plugins/
    pluginsFile=/usr/share/jenkins/plugins.txt

    pluginsInstallWrapper=/usr/local/bin/install-plugins-wrapper.sh

    cat > "$pluginsInstallWrapper" << EOF
#!/usr/bin/env sh

set -e
# set -o

# Parse plugins.txt to be compatible with install-plugins.sh.
# Inspired by: https://github.com/jenkinsci/docker/issues/348
PLUGINS_PARSED="$(sed '/^$/d; /^#.*$/d s/\n\r?/ /g' $pluginsFile)"

if [[ "\$3" == "plugins" ]]; then
    echo "*************** Install plugins..."
    # plugins.sh is deprecated so use install-plugins.sh
    echo "install-plugins.sh $PLUGINS_PARSED"
    install-plugins.sh $PLUGINS_PARSED
    echo "*************** Plugins installed. ($PLUGINS_PARSED)"
else
    echo "Content of: \$2 changed (inotifyd events: \$1). Subfile was: \$3"
fi
EOF
    chmod +x "$pluginsInstallWrapper"

    # Inspired by: http://stackoverflow.com/a/6968589
    # Not working for busybox (alpine) linux with inotifyd only available! (missing inotify-tools)
    # while [[ ! -f "$pluginsDir" ]]; do
        # inotifywait -qqt 2 -e create -e moved_to "$(dirname $pluginsDir)"
        # Test for busybox (missing inotify-tools)
        # inotifyd install-plugins.sh /usr/share/jenkins/plugins.txt $pluginsDir:n
    # done

    # inotifyd install-plugins.sh /usr/share/jenkins/plugins.txt "$(dirname $pluginsDir)":n
    inotifyd "$pluginsInstallWrapper" "$(dirname $pluginsDir)":n
    
else
    echo "*************** Run given command(s): $@"
    exec "$@"
fi




