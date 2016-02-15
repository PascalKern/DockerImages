#!/usr/bin/env bash

DEBUG_PORT=9009

JENKINS_OPTS=(--httpPort=8088)

JAVA_OPTS=(-DJENKINS_HOME=/Users/pkern/var)
# TEST="-Xdebug -Xrunjdwp:transport=dt_socket,address=$DEBUG_PORT,server=y,suspend=n"
# JAVA_OPTS+=("$TEST")
JAVA_OPTS+=(-Xdebug -Xrunjdwp:transport=dt_socket,address=$DEBUG_PORT,server=y,suspend=n)

for switch in "${JAVA_OPTS[@]}"
do
  echo "	$switch"
done

# java -X... -D... -jar jenkins.war --httpPort.... 
echo "java ${JAVA_OPTS[@]} -jar jenkins.war ${JENKINS_OPTS[@]}"
# java "${JAVA_OPTS[@]}" -jar jenkins.war "${JENKINS_OPTS[@]}"

