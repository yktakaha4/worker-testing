#!/usr/bin/make

WORKERS ?= 1

.PHONY: install
install:
	poetry install

.PHONY: fix
fix:
	poetry run black apps && poetry run isort apps

.PHONY: gunicorn
gunicorn:
	poetry run python -m gunicorn apps.asgi:application -k uvicorn.workers.UvicornWorker -w $(WORKERS)

.PHONY: uvicorn
uvicorn:
	poetry run python -m uvicorn apps.asgi:application --workers $(WORKERS)
