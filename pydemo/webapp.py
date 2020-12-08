"""
Flask web app demo
"""
from flask import Flask, request

from . import webfunc


app = Flask(__name__) # pylint: disable=invalid-name


@app.route("/")
def hello():
    """
    Dummy function.
    """
    return webfunc.hello_world()


@app.route('/hello')
def hello_person():
    """
    Dummy function that returns hello + name.
    """
    name = request.args.get("name")
    return webfunc.hello_person(name)
