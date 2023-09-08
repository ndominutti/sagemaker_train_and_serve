# How to run trigger notebook

First of all you should have an environment where to run it, just to list two options:

### 1) An EC2 instance with a jupyter lab running on it

```
#Inside the EC2 pipe python3.9 to python
ln -s /usr/bin/python3.9 /usr/bin/python

#Next create a virtualenv to keep the env tidy
python -m venv env

#activate the env
source env/bin/activate

#Install needed packages
pip install -r requirements.txt

#Run jupyterlab 
#--ip=0.0.0.0 is needed to make jupyter-lab reachable from outside (due to outbound rules listening to ip 0.0.0.0)
#--port 8080 is optional, by default jupyter-lab runs on port 8888
jupyter-lab --ip=0.0.0.0 --port 8080 --no-browser
```

Then access to the jupyter-lab from <public_EC2_url>:8080. Have in mind that you will need the EC2 to have rules for connecting with sagemaker (including invoking the /invocations endpoint)

### 2) A sagemaker studio domain

This is the easiest way, just clone this repo and run

---
There is a __roles.py__ file that is not included into this repo (as it has personal keys). You should create your own with this three strings:
* account_ID: your account ID
* SageMakerExecutionRole: your execution role
* artifact: name a model artifact in S3(only if you have an already trained model.tar.gz model in S3)
