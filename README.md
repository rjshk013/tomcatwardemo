# TomcatMavenApp
Sample Tomcat Maven App


This repo contains sample war file for deploying into any tomcat servers 

give contname as tomcatwardemo

referrence blog : https://www.middlewareinventory.com/blog/jenkins-tomcat-deploy-deploying-application-tomcat-using-jenkins/

Test war is working :
--------------------
http://localhost:8098/TomcatMavenApp/

Steps to deploy war file from jenkins docker container  to tomcat container:
-----------------------------------------------------------------------------
1.Create war file using maven plugin from jenkins(code will be fetched from github repo).here it is : https://github.com/rjshk013/tomcatwardemo
2.The generated waf rom jenkinsserver/workspace location to be deployed on remote tomcat servers webapps folder using Deploy to container plugin
3.Tomcat manager credentials must be given propely
4.Here no nexus configured ,no Jdk extra configured as jenkins server  & tomcat servers comes with java installed .
5.Maven integration Plugin,Maven tools must be installed 

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
3.Build tomcat image from the Dockerfile

docker build -t raju/tomcat8 .

4.Run tomcat docker container 

docker run -d -p 8099:8080 --name tomcat8_dockercontainer -v tomcat8data:/opt/tomcat raju/tomcat8:latest

Note:You cannot use custom volume like /home or /opt infront of tomcat volume.


Publishing Artifacts to Sonatype Nexus using Jenkins Pipelines:
----------------------------------------------------------------
Reference: https://appfleet.com/blog/publishing-artifacts-to-nexus-using-jenkins-pipelines/
This will create a nexus repository docker container and jenkins will upload buildartifacts to this nexus repository

Steps to create nexus docker container:
----------------------------------------

docker pull sonatype/nexus3
docker run -d --name nexus_repo -p 8081:8081 sonatype/nexus3

check nexus server starting status :
docker logs nexus_repo -f 

nexus sign in :
username :admin

First get the password as :

docker exec -i nexus_repo cat /nexus-data/admin.password

After that set a new password

Follow the blog article below

Configure pipeline script :

Given maven tool name as per configured .Here i have given name as Mavenlatest
Since nexus is running docker ,give your local machine ip with port 

To get more info refer: https://dzone.com/articles/jenkins-publish-maven-artifacts-to-nexus-oss-using
