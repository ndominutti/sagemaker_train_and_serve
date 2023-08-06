# This is the file that implements a flask server to do inferences. It's the file that you will modify to
# implement the scoring for your own algorithm.

from __future__ import print_function

import io
import json
import os
import pickle
import signal
import sys
import traceback

from fastapi import FastAPI, Response
import pandas as pd

prefix = "/opt/ml/"
model_path = os.path.join(prefix, "model")


class ScoringService(object):
    model = None

    @classmethod
    def get_model(cls):
        """Get the model object for this instance, loading it if it's not already loaded."""
        if cls.model == None:
            with open(os.path.join(model_path, "decision-tree-model.pkl"), "rb") as inp:
                cls.model = pickle.load(inp)
        return cls.model

    @classmethod
    def predict(cls, input):
        """For the input, do the predictions and return them.

        Args:
            input (pd.DataFrame): The data on which to do the predictions. There will be
                one prediction per row in the dataframe

        Returns:
            _type_: _description_
        """
        clf = cls.get_model()
        return clf.predict(input)


app = FastAPI()


@app.route("/ping", methods=["GET"])
def ping():
    """Determine if the container is working and healthy. In this sample container, we declare
    it healthy if we can load the model successfully."""
    health = ScoringService.get_model() is not None

    status = 200 if health else 404
    return Response(content="\n", status_code=status, media_type="application/json")


@app.route("/invocations", methods=["POST"])
def transformation():
    """Do an inference on a single batch of data. In this sample server, we take data as CSV, convert
    it to a pandas data frame for internal use and then convert the predictions back to CSV (which really
    just means one prediction per line, since there's a single column.
    """
    data = None

    # Convert from CSV to pandas
    if app.request.content_type == "text/csv":
        data = app.request.data.decode("utf-8")
        s = io.StringIO(data)
        data = pd.read_csv(s, header=None)
    else:
        return Response(
            content="This predictor only supports CSV data",
            status_code=415,
            media_type="text/plain",
        )

    print("Invoked with {} records".format(data.shape[0]))

    predictions = ScoringService.predict(data)

    out = io.StringIO()
    pd.DataFrame({"results": predictions}).to_csv(out, header=False, index=False)
    result = out.getvalue()

    return Response(content=result, status_code=200, media_type="text/csv")
