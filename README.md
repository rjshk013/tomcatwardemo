# TomcatMavenApp
Sample Tomcat Maven App


This repo contains sample war file for deploying into any tomcat servers 

give file name as tomcatwardemo

referrence blog : https://www.middlewareinventory.com/blog/jenkins-tomcat-deploy-deploying-application-tomcat-using-jenkins/

Steps to deploy war file from jenkins docker container  to tomcat container:
-----------------------------------------------------------------------------
1.Create war file using maven plugin from jenkins(code will be fetched from github repo).here it is : https://github.com/rjshk013/tomcatwardemo
2.The generated waf rom jenkinsserver/workspace locattion to be deployed on remote tomcat servers webapps folder using Deploy to container plugin
3.Tomcat manager credentials must be given propely
4.Here no nexus configured ,no Jdk extra configured as jenkins server  & tomcat servers comes with java installed .

scenario & environment
------------------------
jenkins & tomcat are running docker containers on same local ubuntu machine.
war file is directly deployed from jenkins server to tomcat server webapps folder

setup tomcat docker container:
-----------------------------

You can create tomcat server in two ways 
1.First pull centos docker image and install latest tomcat into it and run as container
link:https://medium.com/appfleet/deploy-application-using-jenkins-tomcat-server-and-pollscm-4d358fa0d6ee
2.use the Dockerfile from the repo to run tomcat container (no need to pull centos & install java & tomcat as it already contains)
