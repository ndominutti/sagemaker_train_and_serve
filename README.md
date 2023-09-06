# sagemaker_train_and_serve

# Getting started
Create an EC2 linux instance, connect into it through SSH and run the following commands

```
#Install git, clone the main repository and get into it
sudo yum install git
git clone https://github.com/ndominutti/sagemaker_train_and_serve.git
cd sagemaker_train_and_serve

#Change linux_startup.sh to make it executable
chmod +x linux_startup.sh

#Run the startup
sudo ./linux_startup.sh

#Configure aws ID, secret key and region
aws configure
```
---
# Running locally for testing 
```
```
---
# Pushing into ECR
```
#Change to the DIR where the build_and_push code is in and run it
cd /home/<username>/sagemaker_train_and_serve/src/container
sudo ./build_and_push.sh sagemaker-deploy-terraform
```