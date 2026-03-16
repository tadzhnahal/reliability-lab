#!/usr/bin/env bash
set -euo pipefail
TARGET_DIR="${1:-/tmp/reliability-lab-systemd}"
UNIT_PATH="$TARGET_DIR/reliability-lab.service"
mkdir -p "$TARGET_DIR"

cat > "$UNIT_PATH" <<'UNIT'
[Unit]
Description=Reliability Lab Broken Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 /not/existing/path/app.py
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNIT

echo "Created broken unit file:"
echo "$UNIT_PATH"
echo
echo "Failure reason:"
echo "ExecStart points to a non-existing file."
