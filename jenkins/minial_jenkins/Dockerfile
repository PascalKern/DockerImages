# LTS Jenkins (without :alpine, debian jessie with openjdk 1.8 is used)
FROM jenkins:alpine 
# Weekly releases Jenkins
# FROM jenkinsci:jenkins

ENV PLUGINS_FILE=/usr/share/jenkins/plugins.txt \
    JENKINS_OPTS="${JENKINS_OPTS} --prefix=/jenkins" \
    JAVA_OPTS="${JAVA_OPTS} -Djenkins.install.runSetupWizard=false"
    # JAVA_OPTS="${JAVA_OPTS} -Djenkins.install.runSetupWizard=false -Djava.util.logging.config.file=my-logging.properties"

COPY ./data/groovy/* /usr/share/jenkins/ref/init.groovy.d/
# From: https://github.com/geerlingguy/ansible-role-jenkins/issues/50 OR https://github.com/scotty-c/docker-jenkins/blob/master/Dockerfile
# Can not copy to $JENKINS_HOME directly because of the issue noted bellow in the RUN comments!
COPY ./data/jenkins.install.UpgradeWizard.state ./data/my-logging.properties /usr/share/jenkins/ref/
# COPY ./data/logging.propperties /usr/share/jenkins/ref/
COPY ./data/plugins.txt ${PLUGINS_FILE}


USER root
COPY ./data/xxxSupport /usr/local/share/
COPY ./data/xxxSupport/xxxSupport.sh ./data/configSystem.sh ./ data/convertPluginsFileToOneliner.sh /usr/local/bin/
# All three not working because the target to chown is on a mounted voluem!!!
# RUN chown -R jenkins /usr/local/bin /usr/local/share $JENKINS_HOME/ \
# RUN chown -R jenkins /usr/local/bin /usr/local/share $JENKINS_HOME/jenkins.install.UpgradeWizard.state \
    # && bash -c "chown -R jenkins $JENKINS_HOME" \
RUN chown -R jenkins /usr/local/bin /usr/local/share /usr/share/jenkins \
    && mkdir -p /var/log/jenkins \
    && configSystem.sh \
    && echo -e "  * Configured system!\n  * Configured Jenkins for this image.\n  * Jenkins home is set to: $JENKINS_HOME."
    # && echo "DEBUGING:" \
    # && ls -al $JENKINS_HOME \
    # && echo " I'm $(whoami)"
USER jenkins


COPY ./data/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["--help"]