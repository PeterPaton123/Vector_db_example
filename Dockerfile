FROM python:3.10.3-slim-buster
ENV PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y build-essential gcc libpq-dev && rm -rf /var/lib/apt/lists/*
COPY pyproject.toml pyproject.toml
COPY src/ src/
RUN python3 -m venv venv/
RUN venv/bin/python3 -m pip install --upgrade pip setuptools
RUN . venv/bin/activate && pip install . -v --no-cache-dir
ENTRYPOINT ["venv/bin/python3", "src/populate.py"]