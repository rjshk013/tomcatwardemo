FROM centos

MAINTAINER rjshk013@gmail.com

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://mirrors.estointernet.in/apache/tomcat/tomcat-8/v8.5.60/bin/apache-tomcat-8.5.60.tar.gz
RUN tar xvfz apache*.tar.gz
RUN mv apache-tomcat-8.5.60/* /opt/tomcat/.
RUN yum -y install java-1.8.0-openjdk
RUN java -version

WORKDIR /opt/tomcat/
COPY context.xml /opt/tomcat/webapps/host-manager/META-INF/context.xml
COPY context.xml /opt/tomcat/webapps/manager/META-INF/context.xml
COPY tomcat-users.xml /opt/tomcat/conf

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]

