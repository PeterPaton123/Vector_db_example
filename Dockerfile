FROM python:3.10.3-slim-buster
ENV PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y build-essential libpq-dev && rm -rf /var/lib/apt/lists/*
# First install dependencies
COPY pyproject.toml pyproject.toml
RUN python3 -m venv venv/
RUN venv/bin/python3 -m pip install --upgrade pip setuptools
RUN . venv/bin/activate && pip install .
# Copy code and data, this ordering means code changes do not require reinstalling all the dependencies
COPY src/ src/
ENTRYPOINT ["venv/bin/python3", "src/populate.py"]