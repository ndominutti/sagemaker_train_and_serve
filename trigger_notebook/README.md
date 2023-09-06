# Running

´´´
#First lets pipe python3.9 to python
ln -s /usr/bin/python3.9 /usr/bin/python

#Next lets create a virtualenv
python -m venv env

#activate the env
source env/bin/activate

#Install needed packages
pip install -r requirements.txt

#Run jupyterlab 
#--ip=0.0.0.0 is needed to make jupyter-lab reachable from outside (due to outbound rules listening to ip 0.0.0.0)
#--port 8080 is optional, by default jupyter-lab runs on port 8888
jupyter-lab --ip=0.0.0.0 --port 8080 --no-browser
´´´