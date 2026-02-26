#!/usr/bin/env bash
set -euo pipefail

# Mission Control Supabase snapshot (read-only via anon key)
SUPABASE_URL="${SUPABASE_URL:-https://sgcynfmkhqowdboweahz.supabase.co}"
SUPABASE_ANON_KEY="${SUPABASE_ANON_KEY:-}"

if [[ -z "$SUPABASE_ANON_KEY" ]]; then
  # Fallback to current key used by Mission Control dashboard.
  SUPABASE_ANON_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNnY3luZm1raHFvd2Rib3dlYWh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njg3Nzg0OTYsImV4cCI6MjA4NDM1NDQ5Nn0.adsPZ0U_Ce2oM7MWaczBN9sqjVGhFfaht01eBktD6As'
fi

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
OUT_DIR="$ROOT_DIR/backups/$(date +%F)"
STAMP="$(date +%Y%m%d-%H%M%S)"
SNAP_DIR="$OUT_DIR/$STAMP"
mkdir -p "$SNAP_DIR"

fetch_table() {
  local table="$1"
  local query="$2"
  curl -fsS \
    -H "apikey: $SUPABASE_ANON_KEY" \
    -H "Authorization: Bearer $SUPABASE_ANON_KEY" \
    "$SUPABASE_URL/rest/v1/${table}?${query}" \
    > "$SNAP_DIR/${table}.json"
}

fetch_table "tasks" "select=*&order=updated_at.desc.nullslast,created_at.desc.nullslast"
fetch_table "agent_status" "select=*&order=last_heartbeat.desc.nullslast"

cat > "$SNAP_DIR/manifest.json" <<EOF
{
  "created_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "supabase_url": "$SUPABASE_URL",
  "tables": ["tasks", "agent_status"],
  "path": "$SNAP_DIR"
}
EOF

echo "Snapshot complete: $SNAP_DIR"
