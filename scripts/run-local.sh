#!/usr/bin/env bash
set -euo pipefail

source .venv/bin/activate
set -a
source .env
set +a

uvicorn app.src.main:app --host "$APP_HOST" --port "$APP_PORT"
