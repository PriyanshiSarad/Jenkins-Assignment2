From tomcat:8-jre8

# Maintainer 
MAINTAINER "itspriyanshisarad@gmail.com"

COPY ./webapp/target/webapp.war /usr/local/tomcat/webapps/

