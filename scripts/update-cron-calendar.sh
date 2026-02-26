#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "$ROOT/data"
openclaw cron list --json > "$ROOT/data/cron-jobs.json"
echo "Updated $ROOT/data/cron-jobs.json"
