#!/bin/sh

uvicorn app.main:app --reload --proxy-headers --host 0.0.0.0 --port 8000




#!/usr/bin/env python

# import multiprocessing
# import os
# import signal
# import subprocess
# import sys

# cpu_count = multiprocessing.cpu_count()

# model_server_timeout = os.environ.get("MODEL_SERVER_TIMEOUT", 60)
# model_server_workers = int(os.environ.get("MODEL_SERVER_WORKERS", cpu_count))


# def sigterm_handler(nginx_pid: int, gunicorn_pid: int):
#     """
#     Responsible for handling the termination signal (SIGTERM) that may be sent to the server.
#     When the server is requested to shut down (e.g., when you stop or restart the server),
#     it typically receives a SIGTERM signal, which is a signal used to politely request a
#     process to terminate, this function kills the server in a clean way.

#     Graceful termination allows the server to finish processing any pending requests and clean
#     up resources properly before shutting down, reducing the risk of data loss or corruption.

#     Args:
#         nginx_pid (int): nginx Process ID
#         gunicorn_pid (int): gunicorn Process ID
#     """
#     try:
#         os.kill(nginx_pid, signal.SIGQUIT)
#     except OSError:
#         pass
#     try:
#         os.kill(gunicorn_pid, signal.SIGTERM)
#     except OSError:
#         pass

#     sys.exit(0)


# def start_server():
#     """
#     Initiates the FastAPI server to handle incoming HTTP requests and serves it using Gunicorn
#     with Nginx as a reverse proxy.

#     The Nginx process and Gunicorn process are started as subprocesses, and a signal handler for SIGTERM is set
#     to gracefully shut down the server when a termination signal is received.

#     """
#     print("Starting the inference server with {} workers.".format(model_server_workers))

#     # link the log streams to stdout/err so they will be logged to the container logs
#     subprocess.check_call(["ln", "-sf", "/dev/stdout", "/var/log/nginx/access.log"])
#     subprocess.check_call(["ln", "-sf", "/dev/stderr", "/var/log/nginx/error.log"])

#     nginx = subprocess.Popen(["nginx", "-c", "/opt/program/nginx.conf"])
#     gunicorn = subprocess.Popen(
#         [
#             "gunicorn",
#             "--timeout",
#             str(model_server_timeout),
#             "-k",
#             "uvicorn.workers.UvicornWorker",  #'sync',
#             "-b",
#             "unix:/tmp/gunicorn.sock",
#             "-w",
#             str(model_server_workers),
#             "main:app",
#         ]
#     )

#     signal.signal(signal.SIGTERM, lambda a, b: sigterm_handler(nginx.pid, gunicorn.pid))

#     # If either subprocess exits, so do we.
#     pids = set([nginx.pid, gunicorn.pid])
#     while True:
#         pid, _ = os.wait()
#         if pid in pids:
#             break

#     sigterm_handler(nginx.pid, gunicorn.pid)
#     print("Inference server exiting")


# if __name__ == "__main__":
#     start_server()
