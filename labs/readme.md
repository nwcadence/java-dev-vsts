#Java Development on Linux with Visual Studio Team Services  

Overview and Creating the VM
----------------------------

[Microsoft Visual Studio Team Services](https://www.visualstudio.com/products/visual-studio-team-services-vs) makes your software lifecycle better and faster letting you code in Eclipse, IntelliJ, or your favorite Java IDE. You get free unlimited private Git repositories, agile planning and work item tracking tools, and support for builds and continuous integration using Ant, Maven, or Gradle.

The VSTS for Java on Ubuntu Virtual Machine Virtual Machine is a pre-configured, ready to run image on Azure and comes with a set of Hands-On-Labs/Demo scripts to help anyone who wants to learn how Visual Studio Team Services (and Team Foundation Server) provide cross platform tools that enable you to easily build Java solutions.

A set of hands-on-lab documents, which also function as demo scripts, are available for download along with this virtual machine.

Once you get your team environment set up, you'll start working on an Intranet site for a fictitious company, MyShuttle.biz, where you'll update the site, deploy it and test it all with the VM you're using and Visual Studio Team Services.

Target Audience
-----------------------------------------
The image and the accompanying hand-on-labs is for technical audience. As such, familiarity with Visual Studio Team Services, Java and Linux operating system would be preferred although it is not a strict prerequisite.

Hands on Labs
-------------

The labs should be followed in the following order, though there are some equivalent labs that allow you a "choose your adventure" experience:

1. [Setting up a new project on VSTS](Setting up a new project on VSTS.md)
1. [Set up a Docker build agent](Set up a Docker build agent.md)
1. Either:
    1. [Cloning a VSTS Repo - IntelliJ](Cloning a VSTS Repo-IntelliJ.md) **OR**
    1. [Cloning a VSTS Repo - Eclipse](Cloning a VSTS Repo-IntelliJ.md)
1. Either:
    1. [Maven Package Management with VSTS and Jenkins](Maven Package Management with VSTS and Jenkins.md) **OR**
    1. [Maven Package Management with VSTS Team Build](Maven Package Management with VSTS Team Build.md)
1. [Build Docker containers with VSTS](Build Docker containers with VSTS.md)
1. (Optional) [Managing Technical Debt with SonarQube and VSTS Team Build](Managing Technical Debt with SonarQube and VSTS Team Build.md)
1. [Release Management with VSTS](Release Management with VSTS.md)
1. (Optional) [Release Containers to ACS Kubernetes with VSTS](Release Containers to ACS Kubernetes with VSTS.md)
1. Either:
    1. [End to End Workflow - IntelliJ](End to End Workflow-IntelliJ.md)
    1. [End to End Workflow - Eclipse](End to End Workflow-Eclipse.md)