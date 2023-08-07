# Change project_name to your project name
project_name = "ml-pipeline-terraform-demo" 
region = "eu-east-1" 

training_instance_type = "ml.m5.xlarge"
inference_instance_type = "ml.c5.large"
volume_size_sagemaker = 5

# Path to where the handler file is stored (in this case AWS Lambda handler)
handler_path  = "../lambda_function"
# Handler_file-name.handler_function
handler       = "config_lambda.lambda_handler"

