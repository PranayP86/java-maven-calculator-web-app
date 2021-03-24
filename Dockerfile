FROM tomcat:latest
MAINTAINER "Pranay P"

ADD settings.xml /usr/local/tomcat/conf
ADD tomcat-users.xml /usr/local/tomcat/conf/

ADD target/

ENV CATALINA_OPS = "

CMD ["catalina.sh", "run"]
RUN rm -rf $CATALINA_HOME/webapps/ROOT
COPY target/calculator.war $CATALINA_HOME/webapps/ROOT.war
