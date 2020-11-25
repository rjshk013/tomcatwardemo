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
