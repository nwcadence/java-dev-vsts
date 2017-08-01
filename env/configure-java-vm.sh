#!/bin/bash


################################################################
# Section 0 - Validate Input and Get Parameters
################################################################

### Validate parameters
if [[ !("$#" -eq 3) ]]; 
    then echo "Parameters missing for java vm configuration." >&2
    exit 1
fi

### Get parameters
username=$1
azureregion=$2
branch=$3


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

### Install Gradle, Java, Maven, mysql-client
apt-get install gradle maven -y
apt-get install openjdk-8-jdk openjdk-8-jre -y
apt-get install mysql-client -y

### Set environment variable for Java
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /home/$username/.profile
echo "export MAVEN_HOME=/usr/share/maven" >> /home/$username/.profile

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
apt-get install gnome-terminal -y

cd /mnt
git clone https://github.com/nwcadence/java-dev-vsts.git

cd /mnt/java-dev-vsts
git checkout $branch

cp -r /mnt/java-dev-vsts/env/config-template/* /home/$username/.config
find /home/$username/.config -type f -exec sed -i "s/__USERNAME__/$username/g" {} +
chown -R $username /home/$username/.config/*


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


#********
#Temporary fix for xrdp compilation issue due to Ubuntu package missing fontutil.h
#********
#https://github.com/neutrinolabs/xorgxrdp/issues/100
#https://bugs.launchpad.net/ubuntu/+source/libxfont/+bug/1707691
##################################################################
if test -s "/usr/include/X11/fonts/fontutil.h"
then
    echo "fontutil.h already exists...issue is fixed and workaround is no longer necessary"
else
    echo "fontutil.h missing...copying from repo"
    cp /mnt/java-dev-vsts/env/tempXrdpFix/fontutil.h /usr/include/X11/fonts/fontutil.h
fi
#********
#End temporary fix for xrdp compilation issue due to Ubuntu package missing fontutil.h
#********


#Step 2 - Obtain xrdp packages 
################################################################## 

## --Go to your Download folder
echo "Moving to the ~/Download folders..."
echo "-----------------------------------"
cd /mnt


## -- Download the xrdp latest files
echo "Ready to start the download of xrdp package"
echo "-------------------------------------------"
git clone https://github.com/neutrinolabs/xrdp.git

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

echo "-----------------------"
echo "Modify xrdp-sesman.service "
echo "-----------------------"
#Comment the EnvironmentFile - Ubuntu does not have sysconfig folder
sed -i.bak 's/EnvironmentFile/#EnvironmentFile/g' /lib/systemd/system/xrdp-sesman.service

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

### install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.13.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

### Pull Docker images for Jenkins, Sonarqube and VSTS Agent - speeds labs to have images local
docker pull jenkins
docker pull sonarqube
docker pull microsoft/vsts-agent

####################################
# Customize the docker jenkins image

echo "Customizing Jenkins image..."
echo "-----------------------------------"
# create a jenkins build file with a list of plugins to install
# in the RUN command
mkdir -p ~/docker/jenkins
cat >~/docker/jenkins/Dockerfile  <<EOF
FROM jenkins
USER root
RUN apt-get update && apt-get install maven -y && export MAVEN_HOME=/usr/share/maven
RUN /usr/local/bin/install-plugins.sh maven-plugin git sonar jacoco tfs
EOF

# build the image
echo "----building image------------"
docker build -t vsts/jenkins:latest ~/docker/jenkins
####################################

# run the jenkins/sonarqube images
docker run -d --restart=always --name jenkins -e JAVA_OPTS=-Djenkins.install.runSetupWizard=false -p 8080:8080 -p 50000:50000 vsts/jenkins
docker run -d --restart=always --name sonarqube -p 9000:9000 -p 9092:9092 sonarqube

################################################################
# Section 3.5 - Secure docker daemon
################################################################
STR=4096
mkdir -p "/home/$username/.docker"
pushd /home/$username/.docker

if [ ! -f "ca.srl" ]; then
  echo 01 > ca.srl
fi

openssl genrsa \
  -out ca-key.pem $STR

openssl req \
  -new \
  -key ca-key.pem \
  -x509 \
  -days 3650 \
  -nodes \
  -subj "/CN=*" \
  -out ca.pem

openssl genrsa \
  -out server-key.pem $STR

openssl req \
  -subj "/CN=$HOSTNAME" \
  -new \
  -key server-key.pem \
  -out server.csr

echo "subjectAltName = DNS:$HOSTNAME,DNS:$HOSTNAME.$azureregion.cloudapp.azure.com,IP:127.0.0.1,IP:10.0.0.4" > extfile.cnf
openssl x509 \
  -req \
  -days 3650 \
  -in server.csr \
  -CA ca.pem \
  -CAkey ca-key.pem \
  -out server-cert.pem \
  -extfile extfile.cnf

openssl genrsa \
  -out key.pem $STR

openssl req \
  -subj "/CN=docker.client" \
  -new \
  -key key.pem \
  -out client.csr

echo extendedKeyUsage = clientAuth > extfile.cnf

openssl x509 \
  -req \
  -days 3650 \
  -in client.csr \
  -CA ca.pem \
  -CAkey ca-key.pem \
  -out cert.pem \
  -extfile extfile.cnf

# configure daemon
cat >/etc/docker/daemon.json << EOF
{
  "tls": true,
  "tlscert": "/home/$username/.docker/server-cert.pem",
  "tlskey": "/home/$username/.docker/server-key.pem",
  "hosts": ["tcp://$HOSTNAME:2376"]
}
EOF

# fix the docker service file to start without specifying a host
# since the hosts are now defined in the daemon.json file
# there may be a better way to do this without tinkering with the lib docker.service file,
# but I can't find a way
sed -e "s/-H fd:\/\///g" -i /lib/systemd/system/docker.service
systemctl daemon-reload

# set default environment variables
echo "export DOCKER_HOST=tcp://$HOSTNAME:2376" >> /home/$username/.profile
echo "export DOCKER_TLS_VERIFY=1" >> /home/$username/.profile

popd

# add user to docker group to prevent having to use sudo every time
# requires logging out and logging in again
usermod -aG docker $username

####################################
# Configure PhantomJS on VM

echo "Configuring PhantomJS..."
echo "-----------------------------------"
PHANTOM='phantomjs-2.1.1-linux-x86_64'
curl -L https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM.tar.bz2 > $PHANTOM.tar.bz2
tar xvjf $PHANTOM.tar.bz2 -C /usr/local/share
ln -sf /usr/local/share/$PHANTOM/bin/phantomjs /usr/local/share/phantomjs
ln -sf /usr/local/share/$PHANTOM/bin/phantomjs /usr/local/bin/phantomjs
ln -sf /usr/local/share/$PHANTOM/bin/phantomjs /usr/bin/phantomjs
####################################

####################################
# Customize the docker vsts image

echo "Customizing VSTS Agent image..."
echo "-----------------------------------"
# create a custom vstsagent image with phantomjs installed
mkdir -p ~/docker/vstsagent
cp -r /home/$username/.docker ~/docker/vstsagent
cat >~/docker/vstsagent/Dockerfile  <<EOF
FROM microsoft/vsts-agent

# install phantomjs
RUN curl -L https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM.tar.bz2 > $PHANTOM.tar.bz2 && \
  tar xvjf $PHANTOM.tar.bz2 -C /usr/local/share && \
  ln -sf /usr/local/share/$PHANTOM/bin/phantomjs /usr/local/share/phantomjs && \
  ln -sf /usr/local/share/$PHANTOM/bin/phantomjs /usr/local/bin/phantomjs && \
  ln -sf /usr/local/share/$PHANTOM/bin/phantomjs /usr/bin/phantomjs
RUN apt-get update && apt-get install libfontconfig -y

# configure docker
COPY .docker /root/.docker/
ENV DOCKER_HOST=tcp://$HOSTNAME:2376 DOCKER_TLS_VERIFY=1
EOF

# build the image
echo "----building image------------"
docker build -t vsts/agent:latest ~/docker/vstsagent
####################################

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