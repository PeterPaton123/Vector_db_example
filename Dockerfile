FROM python:3.10.3-slim-buster

ENV PYTHONUNBUFFERED=1
ENV POETRY_VERSION 1.8.2

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

RUN pip install "poetry==$POETRY_VERSION"

WORKDIR app/

COPY pyproject.toml poetry.lock* /app/
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi

COPY src/ src/

CMD ["python", "src/populate.py"]
