FROM python:3.12-slim


WORKDIR /app

# Copy dependency manifests
COPY pyproject.toml ./

# Install build dependencies for native extensions (psycopg) and curl for debugging
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	   build-essential \
	   libpq-dev \
	   curl \
	&& rm -rf /var/lib/apt/lists/*

# Install uv (optional) and use pip to install project dependencies from pyproject.toml.
# Use `pip install .` as a reliable fallback which installs declared dependencies.
RUN pip install --no-cache-dir uv setuptools wheel \
	&& (uv install || pip install --no-cache-dir .)

# Copy application source after installing deps to leverage Docker cache
COPY . .

EXPOSE 8000

ENV PYTHONUNBUFFERED=1

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
