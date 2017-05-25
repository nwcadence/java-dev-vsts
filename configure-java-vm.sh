#!/bin/bash


################################################################
# Section 0 - Validate Input and Get Parameters
################################################################

### Validate parameters
if [[ !("$#" -eq 1) ]]; 
    then echo "Parameters missing for java vm configuration." >&2
    exit 1
fi

### Get parameters
username=$1


################################################################
# Section 1 - Install Apps and Files
################################################################
apt-get update

### Install Firefox
apt-get install firefox -y

### Install Chrome
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get update
apt-get install google-chrome-stable --allow-unauthenticated -y


### Install Gradle, Java, Maven
apt-get install gradle -y
apt-get install openjdk-8-jdk openjdk-8-jre -y

### Set environment variables for Java
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-8-openjdk-amd64/bin


### Install UMake
add-apt-repository ppa:ubuntu-desktop/ubuntu-make -y
apt-get update
apt-get install ubuntu-make -y

### Install Eclipse, IntelliJ and VSCode
sudo -u $username umake ide eclipse /home/$username/.local/share/umake/ide/eclipse
sudo -u $username umake ide idea /home/$username/.local/share/umake/ide/idea
sudo -u $username umake ide visual-studio-code --accept-license /home/$username/.local/share/umake/web/visual-studio-code



################################################################
# Section 2 - Configure Desktop Environment and Remote Connectivity
################################################################

### Install and configure xfce and xrdp
apt-get update
apt-get install xfce4 -y
apt-get install xrdp -y


### Compile new version of xrdp
### Modified version of install-xrdp-1.8.sh from http://www.c-nergy.be/blog
################################################################
# Script_Name : install-xrdp-1.8.sh
# Description : Perform an automated custom installation of xrdp
# on ubuntu 16.04.2
# Date : April 2017
# written by : Griffon
# Web Site :http://www.c-nergy.be - http://www.c-nergy.be/blog
# Version : 1.8
#
# Disclaimer : Script provided AS IS. Use it at your own risk....
#
##################################################################
 
#Step 1 - Install prereqs for compilation
##################################################################
 
echo "Installing prereqs for compiling xrdp..."
echo "----------------------------------------"
apt-get -y install libx11-dev libxfixes-dev libssl-dev libpam0g-dev libtool libjpeg-dev flex bison gettext autoconf libxml-parser-perl libfuse-dev xsltproc libxrandr-dev python-libxml2 nasm xserver-xorg-dev fuse git pkg-config

#Step 2 - Obtain xrdp packages 
################################################################## 

 
## --Go to your Download folder
echo "Moving to the ~/Download folders..."
echo "-----------------------------------"
cd /mnt


## -- Download the xrdp latest files
echo "Ready to start the download of xrdp package"
echo "-------------------------------------------"
sudo git clone https://github.com/neutrinolabs/xrdp.git

## -- compiling xrdp packages

echo "Installing and compiling xrdp..."
echo "--------------------------------"
cd /mnt/xrdp
./bootstrap
./configure --enable-fuse --enable-jpeg  
make
make install

#Step 3 -  Download and compiling xorgxrdp packages
################################################################## 
cd /mnt
git clone https://github.com/neutrinolabs/xorgxrdp.git


cd /mnt/xorgxrdp 
./bootstrap 
./configure 
make
make install

#Step 4 - Modify Service Unit Files
################################################################## 


## Needed in order to have systemd working properly with xrdp
echo "-----------------------"
echo "Modify xrdp.service "
echo "-----------------------"

#Comment the EnvironmentFile - Ubuntu does not have sysconfig folder
sed -i.bak 's/EnvironmentFile/#EnvironmentFile/g' /lib/systemd/system/xrdp.service
#Replace /sbin/xrdp with /sbin/local/xrdp as this is the correct location
sed -i.bak 's/sbin\/xrdp/local\/sbin\/xrdp/g' /lib/systemd/system/xrdp.service
echo "-----------------------"
echo "Modify xrdp-sesman.service "
echo "-----------------------"

#Comment the EnvironmentFile - Ubuntu does not have sysconfig folder
sed -i.bak 's/EnvironmentFile/#EnvironmentFile/g' /lib/systemd/system/xrdp-sesman.service
#Replace /sbin/xrdp with /sbin/local/xrdp as this is the correct location
sed -i.bak 's/sbin\/xrdp/local\/sbin\/xrdp/g' /lib/systemd/system/xrdp-sesman.service

#Issue systemctl command to reflect change and enable the service
systemctl daemon-reload
systemctl enable xrdp.service

## copy the following in the .xsession file 
echo xfce4-session >/home/$username/.xsession

## Configure Polkit to avoid popu in Xrdp Session
cat >/etc/polkit-1/localauthority.conf.d/02-allow-colord.conf  <<EOF

polkit.addRule(function(action, subject) {
if ((action.id == “org.freedesktop.color-manager.create-device” ||
action.id == “org.freedesktop.color-manager.create-profile” ||
action.id == “org.freedesktop.color-manager.delete-device” ||
action.id == “org.freedesktop.color-manager.delete-profile” ||
action.id == “org.freedesktop.color-manager.modify-device” ||
action.id == “org.freedesktop.color-manager.modify-profile”) &&
subject.isInGroup(“{group}”)) {
return polkit.Result.YES;
}
});
EOF



################################################################
# Section 3 - Install and Configure Docker
################################################################

### Install Docker

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
apt-get update
apt-get install docker-engine -y

### Pull Docker images for Jenkins and Sonarqube

docker pull jenkins
docker pull sonarqube

####################################
# Customize the docker jenkins image

# create a jenkins build file with a list of plugins to install
# in the RUN command
mkdir ~/docker
cat >~/docker/Dockerfile  <<EOF
FROM jenkins
USER root
RUN apt-get update && apt-get install maven -y
RUN /usr/local/bin/install-plugins.sh maven-plugin git
EOF

# build the image
docker build -t vsts/jenkins:latest ~/docker
####################################

# run the jenkins/sonarqube images
docker run -d --restart=always --name jenkins -e JAVA_OPTS=-Djenkins.install.runSetupWizard=false -p 8080:8080 -p 50000:50000 vsts/jenkins
docker run -d --restart=always --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube

################################################################
# Section 4 - Cleanup and Reboot
################################################################

### Upgrade packages
apt-get upgrade -y

### Reboot
echo "Restart the Computer"
echo "----------------------------"
shutdown -r 1

exit 0