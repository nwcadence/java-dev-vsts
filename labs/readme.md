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

1.	<a href="./1.Setting up a new project on VSTS.md">Module 1: Setting up a new project on VSTS</a> 
    - This module walks you through setting up a VSTS account and Team Project for the rest of the Hands on Labs.
    - Watch the [video overview](https://youtu.be/O1UTj-wZr3k)
2.	<a href="./2.Managing Backlog.md">Module 2: Managing Your Team Project Backlog</a>
    - In this exercise, you are going to examine the various portfolio planning features of Visual Studio to group and manage your work and that of your team using backlogs.
    - Watch the [video overview](https://youtu.be/x4csUGcF4LI)
3.	<a href="./3.Working with Git.md">Module 3: Working with Git</a>
    - In this exercise, you are going to learn how to put some existing code into your Team Project.
    - Watch the [video overview](https://youtu.be/rRlgS1cOcMI)
4.	<a href="./4.Running builds, Unit Tests and Code Coverage.md">Module 4: Running builds, Unit Tests and Code Coverage</a> 
    - In this exercise, you will learn how to create a Team Build that runs in Visual Studio Team Services. This makes it quick and easy to start building your code, either manually or in an automated fashion, without having to worry about any build server configuration.
    - Watch the [video overview](https://youtu.be/HGQS3b0nSng)
5.	<a href="./5.Working with Team Explorer Everywhere.md">Module 5: Working with Team Explorer Everywhere</a> 
    - In this exercise, we will explore Team Explorer Everywhere for Eclipse, a plug-in that provides you with access to features related to Visual Studio Team Services/ Team Foundation Server from within the Eclipse IDE. You will notice that many of the experiences in working with VSTS/TFS in Eclipse are similar to working inside Visual Studio, such as source control, work item tracking, or build automation.
    - Watch the [video overview](https://youtu.be/ATrltkuUN7M)
6.	<a href="./6.Setting up local build agents.md">Module 6: Setting up local build agents</a>  
    - In this exercise, you will configure a VSTS Cross Platform Build & Release Agent on the local machine. You will download and configure the agent.
    - Watch the [video overview](https://youtu.be/OtF4iw-hti4)
7.	<a href="./7.Branches, Pull Requests and CI.md">Module 7: Branches, Pull Requests and CI</a> 
    - In this exercise, we will see how we can create branches for Git repositories, create pull requests and also configure continuous integration.
    - Watch the [video overview](https://youtu.be/GCX6oRgNiqY)
8.	<a href="./8.Automating Deployments with Release Management.md">Module 8: Automating Deployments with Release Management</a> 
    - In this exercise you will download a Tomcat task from the VSTS Marketplace so that you can automate deployment of the website.
    - Watch the [video overview](https://youtu.be/hqfzWDd9DL8)
9.	<a href="./9.Running Selenium Tests.md">Module 9: Running Selenium Tests</a> 
    - In this exercise you will see how to add Selenium tests to the deployment pipeline.
    - Watch the [video overview](https://youtu.be/_JWmnsZVNhQ)
10.	<a href="./10.DeploytoAzure.md">Module 10: Deploying to Azure</a>
    - In this exercise, you will learn how to deploy the application to Azure using Azure Resource Manager templates to create an Azure Resource Group that will contain a virtual machine installed and configured with Java, Tomcat and MySQL.
    - Watch the [video overview](https://youtu.be/1L4eKXo5DHo)
11.	<a href="./11. Application Insights.md">Module 11: Application Insights</a>
    - In this exercise, you will learn how to configure Application Insights to monitor your web application that you have just released
    - Watch the [video overview](https://youtu.be/RPQViU33qqA)

Once you get your team environment set up, you'll start working on an Intranet site for a fictitious company, MyShuttle.biz, where you'll update the site, deploy it and test it all with the VM you're using and Visual Studio Team Services.

Target Audience
-----------------------------------------
The image and the accompanying hand-on-labs is for technical audience. As such, familiarity with Visual Studio Team Services, Java and Linux operating system would be preferred although it is not a strict prerequisite.

Acquiring the VSTS for Java Linux VM 2016
-----------------------------------------

Follow [the instructions](../README.md) to create the VM in Azure.

You are now ready to start using the VM!
