#!groovy

import jenkins.model.*


Jenkins.instance.setNumExecutors(1)

println "--> set number of executors to: 1"
