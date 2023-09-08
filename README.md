# Overview
This repo is an implementation of a sagemaker training and inference endpoint using a __custom container__. It includes all the needed steps as:
* infraestructure building (covered as IaC with Terraform in ./IAC)
* training and serving scripts
* dockerization and push to ECR
* lauching a traning job and an inference endpoint 

The genesis from this implementation comes from the [amazon-sagemaker-examples](https://github.com/aws/amazon-sagemaker-examples/tree/main) repositoy. Some of the code in this repo comes from that source.

Have in mind that custom containers (like the one implemented here) might not be the best way to go for your project, as sagemaker provides pre-built containers for many frameworks as Apache MXNet, Pytorch, XGBoost, Scikit-learn, Tensorflow, etc. Furthermore, if the pre-build containers do not have some dependencies you might need, many of them allow you to add a requirements.txt or you can extend the container creating an image that starts from the pre-build one. Finally you should also consider using a pre-built container in script-mode, to use an external file as entry point. You can check more about this in the [sagemaker oficial documentation](https://docs.aws.amazon.com/pdfs/sagemaker/latest/dg/sagemaker-dg.pdf)

---

# Getting started
To start with the implementation, create an EC2 linux instance, connect into it through SSH and run the following commands

```
#Install git, clone the repository and change directory into it

sudo yum install git
git clone https://github.com/ndominutti/sagemaker_train_and_serve.git
cd sagemaker_train_and_serve


#Change linux_startup.sh to make it executable
chmod +x linux_startup.sh


#Run the startup
sudo ./linux_startup.sh


#Configure aws ID, secret key and region inside the EC2
aws configure
```

---

# Running locally for testing 
For running and testing your code locally you will have to build the image manually, then change directory to /local_test, make the 3 shell files executable and then run each of it in order.
```
#standing in sagemaker_train_serve/src/container
docker build -t <your_image_name> .

#change directory into /local_test and make the files executable
cd local_test
chmod +x train_local.sh && chmod +x serve_local.sh && chmod +x predict.sh

#Run the training process
sudo ./train_local.sh <your_image_name>

#Run local serving
sudo ./serve_local.sh <your_image_name>

#Launch a prediction against you model
sudo ./predict.sh payload.csv
```

---

# Pushing into ECR
You can use the build_and_push.sh file to build and push your image into ECR, but first you will need to make the file executable.
```
#Change to the DIR where the build_and_push code is in and run it
cd /home/<username>/sagemaker_train_and_serve/src/container
sudo ./build_and_push.sh sagemaker-deploy-terraform
```