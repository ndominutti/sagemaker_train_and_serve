## Code structure

The components are as follows:

* __Dockerfile__: The _Dockerfile_ describes how the image is built and what it contains.

* __build\_and\_push.sh__: The script to build the Docker image (using the Dockerfile above) and push it to AWS ECR so that it can be deployed to SageMaker. Specify the name of the image as the argument to this script. The script will generate a full name for the repository in your account and your configured AWS region. If this ECR repository doesn't exist, the script will create it.

* __model__: The directory that contains the application to run in the container.

* __local-test__: A directory containing scripts and a setup for running a simple training and inference jobs locally so that you can test that everything is set up correctly.

### The application run inside the container

When SageMaker starts a container, it will invoke the container with an argument of either __train__ or __serve__. We have set this container up so that the argument in treated as the command that the container executes. When training, it will run the __train__ program included and, when serving, it will run the __serve__ program.

* __train__: The main program for training the model. When you build your own algorithm, you'll edit this to include your training code.
* __serve__: The wrapper that starts the inference server. 
* __main.py__: starts the FASTAPI app.
* __predictor.py__: The algorithm-specific inference server. This is the file that you modify with your own algorithm's code.

### Setup for local testing

The subdirectory local-test contains scripts and sample data for testing the built container image on the local machine. When building your own algorithm, you'll want to modify it appropriately.

* __train-local.sh__: Instantiate the container configured for training.
* __serve-local.sh__: Instantiate the container configured for serving.
* __predict.sh__: Run predictions against a locally instantiated server.
* __test-dir__: The directory that gets mounted into the container with test data mounted in all the places that match the container schema.
* __payload.csv__: Sample data for used by predict.sh for testing the server.