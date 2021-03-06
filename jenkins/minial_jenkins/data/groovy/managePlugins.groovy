#!groovy
// From: https://github.com/blacklabelops/jenkins/tree/master/groovy

import hudson.*
import jenkins.model.*
import java.util.logging.Logger

def logger = Logger.getLogger("")
def installed = false
def initialized = false

def cmd = "/usr/local/bin/convertPluginsFileToOneliner.sh ${EnvVars.masterEnvVars.get('PLUGINS_FILE')}"
println "--> To get plugins list for installation execute: $cmd"
def pluginParameter = cmd.execute().text

//def pluginParameter=EnvVars.masterEnvVars.get("PLUGINS_PARSED")  //"gitlab-plugin hipchat swarm"

def plugins = pluginParameter.split(' ')

logger.info(" * Plugins to install: " + plugins)
def instance = Jenkins.getInstance()
def pm = instance.getPluginManager()
def uc = instance.getUpdateCenter()
uc.updateAllSites()

plugins.each {
  logger.info(" * Checking: " + it)
  if (!pm.getPlugin(it)) {
    logger.info(" * Looking UpdateCenter for: " + it)
    if (!initialized) {
      uc.updateAllSites()
      initialized = true
    }
    def plugin = uc.getPlugin(it)
    if (plugin) {
      logger.info(" * Installing: " + it)
    	plugin.deploy()
      installed = true
    }
  }
}

if (installed) {
  logger.info(" * Plugins installed, initializing a restart!")
  instance.save()
  instance.doSafeRestart()
}