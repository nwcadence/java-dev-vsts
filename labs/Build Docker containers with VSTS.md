## Building Docker Containers with VSTS

In this exercise, you are going to create a Docker Registry in Azure as well as a VSTS build that will build two Docker cotainer images and publish then to the registry. In a later lab you will configure a Release in VSTS to run the containers.

This exercise assumes you have completed the exercises to create a Team Project and have set up the Docker private VSTS agent. You should also have set up Maven package management and have a MyShuttleCalc package in the feed. This exercise uses a team project named **jdev**, though your team project name may differ.

> **Note**: You don't have to use the Azure container registry - you can use whatever registry you choose. You can also create an equivalent build using Jenkins.

Create a Docker Container Registry in Azure
-------------------------------------------
1. Open a browser and navigate to the Azure Portal (https://portal.azure.com).
1. Click the + icon in the upper left of the menu, type "azure container registry" and press Enter.

    ![New Azure Container Registry](images/jenkins-build/new-registry.png "New Azure Container Registry")

1. Click on "Azure Container Registry" and then click the Create button from the Azure Container Registry item blade.

    ![Click Create](images/jenkins-build/start-acr-wizard.png "Click Create")

1. Enter a name, resource group, location and storage account. Click Create when you are done.

    ![Settings for the Registry](images/jenkins-build/new-reg-settings.png "Settings for the Registry")

1. After a few moments, your registry will be created.



Create a VSTS Build to Build Docker Images
------------------------------------------

In this task you will create a VSTS build definition that will create two containers (a mysql database container as well as a tomcat container for running the MyShuttle2 site). The build will publish the containers to the Azure Container Registry you just created.

1. Connect to the virtual machine with the user credentials which you specified when creating the VM in Azure.
1. Open Chrome and browse to `http://<youraccount>.visualstudio.com` (where `youraccount` is the account you created in VSTS).
1. Click on the `jdev` project and navigate to the "Build & Release" Hub.
1. Click on Builds to go the Builds view. Click on "+ New" to create a new Build definition.

    ![Create a new Build Definition](images/jenkins-build/new-build-def.png "Create a new Build Definition")

1. Select Maven from the build templates.