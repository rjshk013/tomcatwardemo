# TomcatMavenApp
Sample Tomcat Maven App


This repo contains sample war file for deploying into any tomcat servers 


referrence blog : https://www.middlewareinventory.com/blog/jenkins-tomcat-deploy-deploying-application-tomcat-using-jenkins/

Test war is working :
--------------------
Since the war file name is TomcatMavenApp need to enter its name
http://localhost:8098/TomcatMavenApp/

Steps to deploy war file from jenkins docker container  to tomcat container:
-----------------------------------------------------------------------------
1.Create war file using maven plugin from jenkins(code will be fetched from github repo).here it is : https://github.com/rjshk013/tomcatwardemo
2.The generated waf rom jenkinsserver/workspace location to be deployed on remote tomcat servers webapps folder using Deploy to container plugin
3.Tomcat manager credentials must be given propely
4.Here no nexus configured ,no Jdk extra configured as jenkins server  & tomcat servers comes with java installed .
5.Maven integration Plugin,Maven tools must be installed 
6.configure jenkins:

build :

 	Goals and options : clean install
Post-build Actions section--->Add post-build action -->Deploy war/ear to container

WAR/EAR files : **/*.war
Context path: noramlly the gitrepofolder whrer the war file present . in this case  tomcatwardemo
Containers : select as per tomcat version like tomcat.8.x .
give credentailas as per configured previously on manage credentail section in jenkins 
Tomcat URL : http://ip:8098 ,if your tomcat docker containers running on local machine give its internal ip with port


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
3.context.xml & tomcat-users.xml files are present in same folder.You may need to change manager-ui credentials if want.
4.Build tomcat image from the Dockerfile

docker build -t raju/tomcat8 .

5.Run tomcat docker container 

docker run -d -p 8099:8080 --name tomcat8_dockercontainer -v tomcat8data:/opt/tomcat raju/tomcat8:latest

Note:You cannot use custom volume like /home or /opt infront of tomcat volume.
6.check tomcat manager ui access
got to browser http://localhost:8098 click manager app --> use the useranme & passwords given in the roles="manager-gui"/> and try to login


docker-compose_tomcat.yml
-------------------------

This will create docker container as per our configuration.The location of Dockerfile will be inside of server folder or If all the folders in the current folder you can give . 


Publishing Artifacts to Sonatype Nexus using Jenkins Pipelines:
----------------------------------------------------------------
Reference: https://appfleet.com/blog/publishing-artifacts-to-nexus-using-jenkins-pipelines/
This will create a nexus repository docker container and jenkins will upload buildartifacts to this nexus repository

Steps to create nexus docker container:
----------------------------------------
pull nexus docker image:
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
1.Create a repository

go to Settings button(server configuration)--create repository --Select maven2 (hosted) recipe from the list ..>
On the Create Repository page,

    Enter the name as maven-nexus-repo
    In Version Policy, select the Mixed type of artifacts.
    Under the Hosted section, in Deployment policy, select Allow redeploy
    
    To create a new user, go to Dashboard > Server Administrator and Configuration > User > Create user. Select Local user type which happens to be the default Realm:
    
    In the Create User page,

    ID: Enter the desired ID; in our case, it is jenkins-user.
    First Name: Enter the desired first name; in our case, it is Jenkins.
    Last Name: Enter the desired second name; in our case, it is User.
    Email: Enter your email address.
    Status: Select Active from your drop-down menu.
    Roles: Make sure that you grant the nx-admin role to your user.


Install and Configure Nexus Plugins in Jenkins:
- Nexus Artifact Uploader
- Pipeline Utility Steps

Add Nexus Repository Manager’s user credentials in Jenkins. Go to Dashboard > Credentials > System > Global credentials (unrestricted)

set up Maven as a managed tool -Ignore if it is already configured 
Configure pipeline script :

Given maven tool name as per configured .Here i have given name as Mavenlatest
Since nexus is running docker ,give your local machine ip with port 

To get more info refer: https://dzone.com/articles/jenkins-publish-maven-artifacts-to-nexus-oss-using
