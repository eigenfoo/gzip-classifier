.DEFAULT_GOAL = help

PYTHON := python3
PIP := pip

.ONESHELL:
.SHELLFLAGS := -e -c
.DELETE_ON_ERROR:
.MAKEFLAGS += --no-builtin-rules

.PHONY: help
help:
	@printf "Usage:\n"
	@grep -E '^[a-zA-Z_-]+:.*?# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?# "}; {printf "\033[1;34mmake %-10s\033[0m%s\n", $$1, $$2}'

.PHONY: venv
venv:  # Set up a Python virtual environment for development.
	@printf "Creating Python virtual environment...\n"
	rm -rf venv/
	${PYTHON} -m venv venv/
	. venv/bin/activate
	${PIP} install -U pip
	${PIP} install -r requirements.txt
	deactivate
	@printf "\n\nVirtual environment created! \033[1;34mRun \`source venv/bin/activate\` to activate it.\033[0m\n\n\n"

.PHONY: clean
clean:  # Clean project directories.
	rm -rf __pycache__/
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name "__pycache__" -delete
	find . -type f -name "*.pyc" -delete
