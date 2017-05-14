#!groovy

import jenkins.model.*


def instance = Jenkins.getInstance()

println "--> ${instance.getInstallState().dump()}"

"echo \"Jenkins is up and called 'test.started.groovy' script!\"".execute()
