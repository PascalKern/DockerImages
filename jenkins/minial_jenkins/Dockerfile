# LTS Jenkins (without :alpine, debian jessie with openjdk 1.8 is used)
FROM jenkins:alpine 
# Weekly releases Jenkins
# FROM jenkinsci:jenkins

USER root
COPY ./data/xxxSupport /usr/local/share/
COPY ./data/xxxSupport/xxxSupport.sh ./data/configSystem.sh /usr/local/bin/
RUN chown -R jenkins /usr/local/bin /usr/local/share/ \
    && configSystem.sh \
    && echo "Configured system!"
# USER ${user}
USER jenkins


COPY ./data/executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
COPY ./data/plugins.txt /usr/share/jenkins/plugins.txt


COPY ./data/docker-entrypoint.sh /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
CMD ["--help"]