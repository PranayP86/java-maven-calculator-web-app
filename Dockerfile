FROM tomcat:latest
MAINTAINER Pranay

ADD ./target/calculator.war /usr/local/tomcat/webapps/

EXPOSE 8080

RUN rm -rf $CATALINA_HOME/webapps/ROOT
COPY target/calculator.war $CATALINA_HOME/webapps/ROOT.war

CMD ["catalina.sh", "run"]
