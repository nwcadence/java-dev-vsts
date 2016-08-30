#Java Development on Linux with Visual Studio Team Services  

Overview and Acquiring the VM
-----------------------------------------

[Microsoft Visual Studio Team Services](https://www.visualstudio.com/products/visual-studio-team-services-vs) makes your software lifecycle better and faster letting you code in Eclipse, IntelliJ, or your favorite Java IDE. You get free unlimited private Git repositories, agile planning and work item tracking tools, and support for builds and continuous integration using Ant, Maven, or Gradle.

The VSTS for Java on Ubuntu Virtual Machine Virtual Machine is a pre-configured, ready to run image on Azure and comes with a set of Hands-On-Labs/Demo scripts to help anyone who wants to learn how Visual Studio Team Services (and Team Foundation Server) provide cross platform tools that enable you to easily build Java solutions.

The virtual machine contains the following pre-configured software:

- Ubuntu Linux 14.04 LTS
- Eclipse Java EE IDE for Web Developers Mars Release 4.5.0
- Microsoft Team Explorer Everywhere Plug-in for Eclipse 14.0.3.201603291051
- Visual Studio Code 0.10.6
- Microsoft VSTS Cross Platform Build and Release Agent 1.999.0
- Firefox 48
- Oracle Java 1.7.0\_05
- Oracle MySQL 5.6.28
- Apache Tomcat 7.0.52
- Apache Maven 3.0.5
- Git 2.9.3
- Gradle 2.7
- NPM 3.3.12
- Node.js 5.5.0
- Sample users and data required to support hands-on-labs which accompany this download.

A set of hands-on-lab documents, which also function as demo scripts, are available for download along with this virtual machine. There are 11 exercises in this walkthrough:

1. <a href="./1.Setting up a new project on VSTS.md">Creating Your Visual Studio Team Services Account and Team Project</a>
2. <a href="./2.Managing Backlog.md">Managing Your Backlog</a>
3. <a href="./3.Working with Git.md">Working with Git</a>
4. <a href="./4.Running builds, Unit Tests and Code Coverage.md">Building your application, running unit tests and code coverage</a>
5. <a href="./5.Working with Team Explorer Everywhere.md">Working with Team Explorer Everywhere</a>
6. <a href="./6.Setting up local build agents.md">Setting up Build and Release Agent on Linux</a>
7. <a href="./7.Branches, Pull Requests and CI.md">Collaborating on code changes with Pull Requests</a>
8. <a href="./8.Automating Deployments with Release Management.md">Using Release Management to deploy your application to Tomcat</a>
9. <a href="./9.Running Selenium Tests.md">Running Automated UI Test with Selenium</a>
10. <a href="./10.DeploytoAzure.md">Deploying to Azure</a>
11. <a href="./11. Application Insights.md">Monitoring with Application Insights</a>


Once you get your team environment set up, you&#39;ll start working on an Intranet site for a fictitious company, MyShuttle.biz, where you&#39;ll update the site, deploy it and test it all with the VM you&#39;re using and Visual Studio Team Services.

Target Audience
-----------------------------------------
The image and the accompanying hand-on-labs is for technical audience. As such, familiarity with Visual Studio Team Services, Java and Linux operating system would be preferred although it is not a strict prerequisite.

Acquiring the VSTS for Java Linux VM 2016
-----------------------------------------

In order to run on Azure, you will need to add the VHD to your Azure storage and use it as an image and create VM based on the image:





You are now ready to start using the VM!!!
