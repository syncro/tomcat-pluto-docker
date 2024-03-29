FROM openjdk:8

ENV TZ Europe/Moscow

EXPOSE 8080


ENV PLUTO_VERSION 2.1.0-M3
ENV DEPLOY_DIR /deployments

USER root




# Get and Unpack Tomcat
#RUN curl -L https://github.com/syncro/tomcat-pluto-docker/releases/download/pluto-${PLUTO_VERSION}/pluto-${PLUTO_VERSION}-bundle.tar.bz2 -o /tmp/pluto.tar.bz2 \
# && tar xjf /tmp/pluto.tar.bz2 -C /opt \
# && ln -s /opt/pluto-${PLUTO_VERSION} /opt/tomcat \
# && chown -R jboss /opt/tomcat /opt/apache-tomcat-${TOMCAT_VERSION} \
# && rm /tmp/pluto.tar.bz2


ADD docker/pluto-${PLUTO_VERSION}-bundle.tar.bz2 /opt

 
RUN ln -s /opt/pluto-${PLUTO_VERSION} /opt/tomcat 
 
# Add roles
#ADD tomcat-users.xml /opt/apache-tomcat-${TOMCAT_VERSION}/conf/


# Startup script
ADD docker/deploy-and-run.sh /opt/tomcat/bin/
##ADD docker/tomcat-users.xml /opt/tomcat/conf/
ADD docker/manager-context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
#ADD docker/lib/* /opt/tomcat/lib/

ADD deployments /deployments

RUN chmod 755 /opt/tomcat/bin/deploy-and-run.sh \
 && rm -rf /opt/tomcat/webapps/examples /opt/tomcat/webapps/docs  \
 && chgrp -R 0 /opt/tomcat/webapps \
 && chmod -R g=u /opt/tomcat/webapps

 

VOLUME [ "/opt/tomcat/logs", "/opt/tomcat/work", "/opt/tomcat/temp", "/tmp/hsperfdata_root" ]


ENV CATALINA_HOME /opt/tomcat
ENV PATH $PATH:$CATALINA_HOME/bin


CMD ["deploy-and-run.sh"]

##USER jboss

