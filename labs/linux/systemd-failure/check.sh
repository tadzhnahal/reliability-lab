#!/usr/bin/env bash
set -euo pipefail

echo "systemd-failure scenario status"
echo

test -x labs/linux/systemd-failure/break.sh && echo "break.sh: ok" || { echo "break.sh: missing"; exit 1; }
test -x labs/linux/systemd-failure/recover.sh && echo "recover.sh: ok" || { echo "recover.sh: missing"; exit 1; }

echo
echo "Scenario files are ready"
