## Building Projects with Jenkins

In this exercise, you are going to set up a Jenkins job to build the MyShuttle2 code. The build is going to create Docker images which you will configure to run using VSTS Release Management in a later exercise.

This exercise assumes you have completed the exercises to create a Team Project and have set up the Docker private VSTS agent. You should also have set up Maven package management and have a MyShuttleCalc package in the feed. This exercise uses a team project named **jdev**, though your team project name may differ.

> **Note**: You can also create an equivalent build using VSTS Team Build.

Configure Maven Tools for Jenkins
---------------------------------

In this task you will configure Jenkins, which is running in a container on your VM, so that it is ready to run jobs.

1. In the browser on your VM, navigate to `http://localhost:8080/configureTools/` to open the Jenkins tools configuration page.
1. Scroll down to the Maven section and click the "Add Maven" button.
1. Enter `default` for the name and uncheck the "Install automatically" checkbox.
1. Enter `/usr/share/maven` into the MAVEN_HOME field. Click the "Save" button.

    ![Configure Maven](images/jenkins-build/configure-maven.png "Configure Maven")

Create a Maven Job
------------------
1. Click back on "Jenkins" in the toolbar to navigate to the home page.



