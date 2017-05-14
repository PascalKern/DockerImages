#!groovy

import jenkins.model.*


def instance = Jenkins.getInstance()

println "--> ${instance.getInstallState().dump()}"
println "==> java.util.logging.config.file = ''${System.getProperty('java.util.logging.config.file')}'"


println "echo \"==> Jenkins is up and called 'test.started.groovy' script!\"".execute().text

println "/usr/local/bin/install-plugins-wrapper.sh".execute().text
