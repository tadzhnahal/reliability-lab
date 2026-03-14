#!/usr/bin/env bash
set -uo pipefail

missing=0

check_cmd() {
  local name="$1"

  if command -v "$name" >/dev/null 2>&1; then
    echo "$name: ok"
  else
    echo "$name: missing"
    missing=1
  fi
}

echo "Проверяем Python"
python3 --version || missing=1

echo
echo "Проверяем pip"
pip3 --version || missing=1

echo
echo "Проверяем git"
git --version || missing=1

echo
echo "Проверяем gh"
check_cmd gh

echo
echo "Проверяем docker"
docker --version || missing=1

echo
echo "Проверяем docker compose"
docker compose version || missing=1

echo
echo "Проверяем docker daemon"
if docker info >/dev/null 2>&1; then
  echo "docker daemon: ok"
else
  echo "docker daemon: fail"
  missing=1
fi

echo
echo "Проверяем .venv"
if test -d .venv; then
  echo ".venv: ok"
else
  echo ".venv: missing"
  missing=1
fi

echo
echo "Проверяем .env"
if test -f .env; then
  echo ".env: ok"
else
  echo ".env: missing"
  missing=1
fi

echo
echo "Проверяем requirements"
if test -f app/requirements.txt; then
  echo "requirements: ok"
else
  echo "requirements: missing"
  missing=1
fi

echo
if [ "$missing" -eq 0 ]; then
  echo "Среда готова"
  exit 0
else
  echo "WOOPAAA, среда не готова, установи остальные инструменты и запусти проверку снова."
  exit 1
fi
