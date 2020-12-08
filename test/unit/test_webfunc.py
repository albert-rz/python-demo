"""
Webfunc unit tests
"""
from pydemo import webfunc


def test_hello_person():
    """
    Test hello_person
    """
    assert webfunc.hello_person("Max") == "Hello Max!"
