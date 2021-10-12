DC = $(shell which docker-compose)
DOCKER = $(shell which docker)

all: help

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  run           - docker-compose up the entire system for dev"
	@echo "  freeze        - freeze the Flask app to write static HTML files"
	@echo "  build         - build docker images for dev"
	@echo "  rebuild       - force a rebuild of all of the docker images"
	@echo "  stop          - stop all docker containers"
	@echo "  kill          - kill all docker containers (more forceful than stop)"
	@echo "  shell         - open a bash shell in the running app"
	@echo "  run-shell     - open a bash shell in a fresh container"
	@echo "  clean         - remove all build, test, coverage and Python artifacts"
	@echo "  lint          - check style with flake8, eslint, and stylelint"


run:
	${MAKE} build
	${DC} up app

freeze:
	${MAKE} build
	${DC} run --rm app python freeze.py

build:
	${DC} build app

rebuild: clean build

stop:
	${DC} stop

kill:
	${DC} kill

shell:
	${DC} exec app bash

run-shell:
	${DC} run --rm app bash

clean:
#	python related things
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -rf {} +
#	test related things
	-rm -f .coverage
#	static files
	-rm -rf build/
# clean untracked files & directories
#	git clean -d -f

lint:
	${MAKE} build
	${DC} run app flake8
	${DC} run app npm run lint


.PHONY: all run freeze build rebuild stop kill shell run-shell clean lint

