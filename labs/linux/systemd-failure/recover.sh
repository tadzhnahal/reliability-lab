#!/usr/bin/env bash
set -euo pipefail
TARGET_DIR="${1:-/tmp/reliability-lab-systemd}"
UNIT_PATH="$TARGET_DIR/reliability-lab.service"
mkdir -p "$TARGET_DIR"
cat > "$UNIT_PATH" <<'UNIT'

[Unit]
Description=Reliability Lab Fixed Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/python3 -m http.server 8001
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNIT

echo "Created fixed unit file:"
echo "$UNIT_PATH"
echo
echo "Fix:"
echo "ExecStart now points to a valid command."
