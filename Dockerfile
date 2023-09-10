FROM python:3.10

RUN apt update

ADD . /app
WORKDIR /app

RUN pip install --upgrade pip && pip install poetry
RUN poetry config virtualenvs.create false
RUN poetry install --no-dev
