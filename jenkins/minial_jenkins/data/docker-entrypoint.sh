#!/usr/bin/env sh

set -e
# set -o


if [[ -z ${1+x} || "$1" == "--"* || "$1" == "jenkins" || "$1" == "--help" ]]; then    #If not set first parameter OR first parameter starts with "--" or equals jenkins OR is just the CMD from the Dockerfile
    if [[ "$1" == "--help" ]]; then
        shift
    fi
    if [[ "$1" == "--"* || "$1" == "jenkins" ]]; then
        echo "*************** Start jenkins... (Additional given parameters: $@)"
    else
        echo "*************** Start jenkins..."
    fi

    cp /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state $JENKINS_HOME
    cp /usr/share/jenkins/ref/my-logging.properties $JENKINS_HOME
    
    # exec tini -s -- /usr/local/bin/jenkins.sh &
    tini -s -- /usr/local/bin/jenkins.sh "$@" &
    # init tini -s -- /usr/local/bin/jenkins.sh &    
    
    if [[ 0 -ne $? ]]; then
        echo "Could not start jenkins! Error: $?"
        exit -1
    fi

    pluginsDir=$JENKINS_HOME/plugins/
    pluginsFile=$PLUGINS_FILE

    pluginsInstallWrapper=/usr/local/bin/install-plugins-wrapper.sh

    cat > "$pluginsInstallWrapper" << EOF
#!/usr/bin/env sh

set -e
# set -o

# Parse plugins.txt to be compatible with install-plugins.sh.
# Inspired by: https://github.com/jenkinsci/docker/issues/348
PLUGINS_PARSED="$(convertPluginsFileToOneliner.sh $pluginsFile)"

if [[ "\$3" == "plugins" && "x\$PLUGINS_PARSED" != "x" ]]; then
    echo "*************** Install plugins..."
    # plugins.sh is deprecated so use install-plugins.sh
    echo "install-plugins.sh \$PLUGINS_PARSED"
    install-plugins.sh \$PLUGINS_PARSED
    echo "*************** Plugins installed temporary into $(dirname $pluginsFile)/ref/plugins." # (\$PLUGINS_PARSED)"
    mv $(dirname $pluginsFile)/ref/plugins/* $JENKINS_HOME/plugins
    echo "\$(ls \$JENKINS_HOME/plugins | tr '\n' ' ')"
    echo "*************** Plugins moved into $JENKINS_HOME/plugins"
    exit 0
else
    # echo "NOTIFYD UPDATE: (not plugins dir) Content of: \$2 changed (inotifyd events: \$1). Subfile was: \$3"
    exit 1
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
    # inotifyd "$pluginsInstallWrapper" "$(dirname $pluginsDir)":n
    
else
    echo "*************** Run given command(s): $@"
    exec "$@"
fi




