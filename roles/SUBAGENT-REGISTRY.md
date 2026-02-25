# Mission Control Sub-Agent Registry

Created: 2026-02-24

## Orchestration Policy
- Keep **Conrad** primarily available for direct user requests.
- Route role-specific and background execution to mission-control sub-agents by default.
- Use Conrad as coordinator/escalation path to reduce overload and avoid model rate-limit pressure.

## Active Sub-Agents

- `peter-cto` — CTO (⚙️ Peter)
  - Workspace: `agents/mission-control/peter-cto/`
  - Skills: coding-agent, github, healthcheck, tmux
  - Protocol: Use Claude Code via `coding-agent` for deep coding tasks.

- `alex-head-of-sales` — Head of Sales (📈 Alex)
  - Workspace: `agents/mission-control/alex-head-of-sales/`
  - Skills: gh-issues, gog, summarize

- `martin-chief-hustle-officer` — Chief Hustle Officer (🔥 Martin)
  - Workspace: `agents/mission-control/martin-chief-hustle-officer/`
  - Skills: gog, summarize

- `vale-chief-relocation-officer` — Chief Relocation Officer (🧭 Vale)
  - Workspace: `agents/mission-control/vale-chief-relocation-officer/`
  - Skills: things-mac, gog, summarize

- `tony-chief-life-officer` — Chief Life Officer (🌱 Tony)
  - Workspace: `agents/mission-control/tony-chief-life-officer/`
  - Skills: apple-reminders, things-mac, weather

- `nemo-chief-research-officer` — Chief Research Officer (🔬 Nemo)
  - Workspace: `agents/mission-control/nemo-chief-research-officer/`
  - Skills: summarize, gemini, github

- `atlas-chief-opportunity-officer` — Chief Opportunity Officer (🛰️ Atlas)
  - Workspace: `agents/mission-control/atlas-chief-opportunity-officer/`
  - Skills: summarize, github, gog

- `pei-ling-creative-strategist` — Creative Strategist (🎨 Pei-Ling)
  - Workspace: `agents/mission-control/pei-ling-creative-strategist/`
  - Skills: remotion, coding-agent, nano-banana-pro

- `marly-media-manager` — Media Manager (📊 Marly)
  - Workspace: `agents/mission-control/marly-media-manager/`
  - Skills: summarize, gog

## Standard Workspace Files (per sub-agent)
- `IDENTITY.md`
- `SOUL.md`
- `USER.md`
- `ROLE-PROTOCOL.md`
- `AGENTS.md`
- `MEMORY.md`
- `memory/` daily logs
