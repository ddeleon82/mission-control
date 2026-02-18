# Mission Control

Executive multi-agent dashboard for Freedom & Coffee.

## Overview

An org-chart style command center for managing AI agent roles:
- **CEO (Dom)** — Decision maker, protected flow time
- **Chief of Staff (Conrad)** — Hub/orchestrator, daily briefs
- **Head of Sales** — Pipeline, follow-ups, outreach
- **CTO** — System health, security, infrastructure
- **Chief Life Officer** — Long-game tracking, balance

## Architecture

```
         ┌─────────────┐
         │     DOM     │
         │    (CEO)    │
         └──────┬──────┘
                │
         ┌──────┴──────┐
         │   CONRAD    │
         │    (CoS)    │
         └──────┬──────┘
                │
    ┌───────────┼───────────┐
    │           │           │
┌───┴───┐  ┌────┴────┐  ┌───┴───┐
│ SALES │  │   CTO   │  │ LIFE  │
└───────┘  └─────────┘  └───────┘
```

## Tech Stack

- Single HTML file (zero build)
- Supabase for real-time data
- Password-protected (SHA-256 hash gate)
- Same backend as Conrad's Kanban

## Local Development

Just open `index.html` in a browser. Password: `freedomandcoffee`

## Deployment

Push to GitHub, enable Pages on main branch.

## Related

- [PRD](/docs/PRD-multi-agent-system.md) — Full product design document
- [Kanban](/kanban/) — Task board
- [Memory](/memory/) — Agent memory files

---

Built by Conrad 🎭
