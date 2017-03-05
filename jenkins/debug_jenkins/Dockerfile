FROM jenkins:latest
MAINTAINER Pascal Kern <pascal.kern@gmail.com>


# For sudo access inside the container terminal
USER root
RUN apt-get update \
      && apt-get install -y sudo \
      && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
USER jenkins


# To fix the wrong handling of multiple element env properties with quotes! 
# Defect in jenkins.sh from: https://github.com/jenkinsci/docker
USER root
# RUN ["/bin/bash", "-c", "sed", "-i", "-r", "'s/CMD\+=\("\$(JAVA_OPTS|JENKINS_OPTS)"\)/CMD+=\(\$\1\)/'", "/usr/local/bin/jenkins.sh"]
RUN sed -i'.prev' -r 's/CMD\+=\(\"\$(JAVA_OPTS|JENKINS_OPTS)\"\)/CMD\+=\(\$\1\)/' /usr/local/bin/jenkins.sh
USER jenkins

# Remote Debuging Socket and JVM configuration (Jetty war execution!)
EXPOSE 9009
ENV JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=9009,server=y,suspend=n"


# Load plugins from the copied file
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt