#!groovy

//From: https://github.com/visualphoenix/jenkins-init-scripts
//See (how to use): https://github.com/visualphoenix/docker-jenkins-demo/blob/592f10ac0892f7002a49ddc61cc2f575bd4a9859/master/init.groovy.d/init.groovy

import hudson.*
import jenkins.model.*

// Configure global master-slave security
def master_slave_security = { instance, home, disabled=true ->
/*  s = new File(home + '/secrets/filepath-filters.d').mkdirs()
  s = new File(home + '/secrets/filepath-filters.d/50-gui.conf').createNewFile()
  s = new File(home + '/secrets/whitelisted-callables.d').mkdirs()
  s = new File(home + '/secrets/whitelisted-callables.d/gui.conf').createNewFile()*/
  instance.getInjector().getInstance(jenkins.security.s2m.AdminWhitelistRule.class).setMasterKillSwitch(disabled)
  println "--> Enabled Master -> Slave Security (value: $disabled)"
}

master_slave_security(Jenkins.getInstance(), EnvVars.masterEnvVars.get("JENKINS_HOME"))
