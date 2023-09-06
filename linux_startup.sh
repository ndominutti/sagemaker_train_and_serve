#!/bin/sh

#Install docker, start the daemon and configure it to run with root permission
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
#set build_and_push.sh as an excecutable file and then run it with the name
#you want to give to the image
cd src/container
chmod +x build_and_push.sh
#Lets install terraform 1.5.6 as it was the latest version when this repo was created
curl -O https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
unzip terraform_1.5.6_linux_amd64.zip
sudo mv terraform /usr/local/bin/
echo "---------DONE!---------"