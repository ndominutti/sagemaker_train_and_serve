# sagemaker_train_and_serve

# Getting started
Create an EC2 linux instance

```
#Install git, clone the main repository and get into it
sudo yum install git
git clone https://github.com/ndominutti/sagemaker_train_and_serve.git
cd sagemaker_train_and_serve

#First lets change linux_startup.sh to an executable file
chmod +x linux_startup.sh

#Run the startup
sudo ./linux_startup.sh

#Now change to the DIR where the build_and_push code is in and run it
cd src/container
sudo ./build_and_push.sh sagemaker-deploy-terraform
```
