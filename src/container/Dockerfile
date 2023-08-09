FROM ubuntu:22.04

RUN pip install --upgrade pip
RUN apt-get -y update && apt-get install -y --no-install-recommends\
         wget \
         python3-pip \
         python3-setuptools \
         nginx \
         ca-certificates 
    #&& rm -rf /var/lib/apt/lists/*


#RUN ln -s /usr/bin/python3 /usr/bin/python
#RUN ln -s /usr/bin/pip3 /usr/bin/pip


# Set some environment variables. PYTHONUNBUFFERED keeps Python from buffering our standard
# output stream, which means that logs can be delivered to the user quickly. PYTHONDONTWRITEBYTECODE
# keeps Python from writing the .pyc files which are unnecessary in this case. We also update
# PATH so that the train and serve programs are found when the container is invoked.
ENV PYTHONUNBUFFERED=TRUE
ENV PYTHONDONTWRITEBYTECODE=TRUE
ENV PATH="/opt/program:${PATH}"


COPY model /opt/program
RUN pip install -r ./opt/program/requirements.txt


WORKDIR /opt/program
RUN chmod +x train 


