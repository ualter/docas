FROM jenkins

USER root

######################
## S.O. Settings
RUN apt-get update \
        && apt-get install -y sudo
######################

######################
## Installing Plugins
COPY plugins/list.txt /var/jenkins_home/listPlugins.txt
RUN /usr/local/bin/plugins.sh /var/jenkins_home/listPlugins.txt
######################

######################
## Java Configs
COPY config/jaxp.properties /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/
######################

######################
## Jenkins settings
COPY config/config.xml /usr/share/jenkins/ref/config.xml
COPY config/hudson.tasks.Maven.xml /usr/share/jenkins/ref/hudson.tasks.Maven.xml
COPY config/maven-global-settings-files.xml /usr/share/jenkins/ref/maven-global-settings-files.xml
COPY config/jenkins.mvn.GlobalMavenConfig.xml /usr/share/jenkins/ref/jenkins.mvn.GlobalMavenConfig.xml
COPY config/hudson.plugins.sonar.SonarGlobalConfiguration.xml /usr/share/jenkins/ref/hudson.plugins.sonar.SonarGlobalConfiguration.xml
COPY config/mapping-job-config.xml /var/jenkins_home/mapping-job-config.xml
######################

USER jenkins






