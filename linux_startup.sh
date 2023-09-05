#!/bin/sh

#Install git and clone the main repository
sudo yum install git
git clone https://github.com/ndominutti/sagemaker_train_and_serve.git
#Install docker, start the daemon and configure it to run with root permission
sudo yum install docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
#set build_and_push.sh as an excecutable file and then run it with the name
#you want to give to the image
cd src/container
chmod +x build_and_push.sh