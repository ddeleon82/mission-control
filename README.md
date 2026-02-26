# Mission Control

Executive multi-agent dashboard for Freedom & Coffee.

## Overview

An org-chart style command center for managing AI agent roles:
- **CEO (Dom)** — Decision maker, protected flow time
- **Chief of Staff (Conrad)** — Hub/orchestrator, daily briefs
- **Head of Sales** — Pipeline, follow-ups, outreach
- **CTO** — System health, security, infrastructure
- **Chief Life Officer** — Long-game tracking, balance

## Features

- **Overview** — Agent status, activity feed, priority queue
- **Agents** — Detailed agent cards with real-time Supabase status
- **Tasks** — Kanban-style task board (backlog/in-progress/done) synced with Supabase
- **Daily Brief** — Priorities, email triage, calendar, pipeline, life check
- **Pipeline** — Sales leads and SDR build status
- **Cron Calendar** — Monthly calendar view of cron jobs (with failure/health badges)
- **Org Chart** — Visual hierarchy with phase 2 preview

## Tech Stack

- Single HTML file (zero build)
- Supabase for real-time data (agent_status, tasks tables)
- Password-protected (SHA-256 hash gate)
- `memory/tasks.md` remains source of truth; Supabase for display

## Local Development

Just open `index.html` in a browser. Password: `freedomandcoffee`

## Deployment

Push to GitHub, enable Pages on main branch.

## Operational Safety: Data Snapshots

Use the included script to take a read-only Supabase snapshot of the two live tables (`tasks`, `agent_status`) before major changes:

```bash
./scripts/snapshot_supabase.sh
```

Output is written locally to timestamped folders under:

- `backups/YYYY-MM-DD/YYYYMMDD-HHMMSS/`

This reduces rollback risk and gives you a quick local restore reference if a bad write or schema change causes dashboard issues.

## Cron Calendar Data Sync

Mission Control reads cron jobs from `data/cron-jobs.json`.
Refresh it before pushing dashboard updates:

```bash
./scripts/update-cron-calendar.sh
```

## History

- **v1** — Original kanban board (conrad-kanban, now archived)
- **v2** — Mission Control dashboard with agent roles
- **v3** — Consolidated task management from kanban

---

Built by Conrad 🎭
