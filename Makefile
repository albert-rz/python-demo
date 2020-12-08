.PHONY: envlint run unit apidoc html doc clean

.DEFAULT_GOAL=default

MAKEFLAGS=--silent --ignore-errors

PY=python3

PY_ENV=.venv/bin/python3
PIP_ENV=.venv/bin/pip3

SPHINX_APIDOC=.venv/bin/sphinx-apidoc
SPHINX_BUILD=.venv/bin/sphinx-build

API=docs/api
API_SOURCE=$(API)/source
API_BUILD=$(API)/build
API_HTML=$(API_BUILD)/html

export FLASK_APP=pydemo/webapp.py

env:
	@test -d .venv || $(PY) -m venv .venv && $(PIP_ENV) install wheel
	$(PIP_ENV) install -r requirements.txt


lint:
	$(PY_ENV) -m pylint pydemo
	$(PY_ENV) -m mypy pydemo


run:
	$(PY_ENV) -m flask run


unit:
	$(PY_ENV) -m pytest --doctest-modules --cov=pydemo --cov-report=term-missing \
		--cov-report=html test/unit


apidoc:
	$(SPHINX_APIDOC) -f -o $(API_SOURCE) pydemo pydemo/webapp.py


html:
	$(SPHINX_BUILD) -b html $(API_SOURCE) $(API_HTML)


doc: apidoc html


evil-push:
	rm -rf .git
	git init
	git checkout -b main
	git add .
	git commit -m "Initial commit"
	git remote add origin https://github.com/albert-rz/python-demo.git
	git push -u --force origin main


push:
	git add .
	git commit -am "Update"
	git push


clean:
	rm -rf $(API_BUILD)
	rm -rf .coverage .mypy_cache .pytest_cache htmlcov
	find . -name '__pycache__' -exec rm -rf {} +
