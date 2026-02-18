-- Multi-Agent Roles table for Mission Control
-- Run this in Supabase SQL Editor

-- Roles table
CREATE TABLE IF NOT EXISTS roles (
  id TEXT PRIMARY KEY,                              -- e.g., 'chief-of-staff', 'head-of-sales'
  name TEXT NOT NULL,                               -- Display name
  emoji TEXT,                                       -- Role emoji/icon
  status TEXT NOT NULL DEFAULT 'idle',              -- active, idle, offline
  current_task TEXT,                                -- What the role is working on
  last_active TIMESTAMPTZ DEFAULT NOW(),
  
  -- Role-specific stats (JSON for flexibility)
  stats JSONB DEFAULT '{}',
  
  -- Configuration
  autonomy_level TEXT DEFAULT 'recommend',          -- autonomous, recommend, alert-only
  model TEXT DEFAULT 'sonnet',                      -- opus, sonnet
  
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Daily briefs table
CREATE TABLE IF NOT EXISTS daily_briefs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  date DATE NOT NULL DEFAULT CURRENT_DATE,
  content JSONB NOT NULL,                           -- Structured brief data
  generated_at TIMESTAMPTZ DEFAULT NOW(),
  
  UNIQUE(date)
);

-- Role activity/decisions log
CREATE TABLE IF NOT EXISTS role_activity (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  role_id TEXT REFERENCES roles(id) ON DELETE SET NULL,
  action_type TEXT NOT NULL,                        -- decision, task_complete, alert, handoff
  summary TEXT NOT NULL,
  details JSONB,
  requires_attention BOOLEAN DEFAULT false,
  acknowledged BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE roles ENABLE ROW LEVEL SECURITY;
ALTER TABLE daily_briefs ENABLE ROW LEVEL SECURITY;
ALTER TABLE role_activity ENABLE ROW LEVEL SECURITY;

-- Public read policies (write requires auth)
CREATE POLICY "Public read roles" ON roles FOR SELECT USING (true);
CREATE POLICY "Authenticated write roles" ON roles FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Public read briefs" ON daily_briefs FOR SELECT USING (true);
CREATE POLICY "Authenticated write briefs" ON daily_briefs FOR ALL USING (auth.role() = 'authenticated');

CREATE POLICY "Public read role_activity" ON role_activity FOR SELECT USING (true);
CREATE POLICY "Authenticated write role_activity" ON role_activity FOR ALL USING (auth.role() = 'authenticated');

-- Anon write policies (for now, tighten later)
CREATE POLICY "Anon insert roles" ON roles FOR INSERT WITH CHECK (true);
CREATE POLICY "Anon update roles" ON roles FOR UPDATE USING (true);

CREATE POLICY "Anon insert briefs" ON daily_briefs FOR INSERT WITH CHECK (true);
CREATE POLICY "Anon update briefs" ON daily_briefs FOR UPDATE USING (true);

CREATE POLICY "Anon insert role_activity" ON role_activity FOR INSERT WITH CHECK (true);

-- Enable realtime
ALTER PUBLICATION supabase_realtime ADD TABLE roles;
ALTER PUBLICATION supabase_realtime ADD TABLE daily_briefs;
ALTER PUBLICATION supabase_realtime ADD TABLE role_activity;

-- Indexes
CREATE INDEX IF NOT EXISTS idx_role_activity_role ON role_activity(role_id);
CREATE INDEX IF NOT EXISTS idx_role_activity_created ON role_activity(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_role_activity_attention ON role_activity(requires_attention) WHERE requires_attention = true;

-- Auto-update trigger for roles
CREATE TRIGGER roles_updated_at
  BEFORE UPDATE ON roles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();

-- Seed initial roles
INSERT INTO roles (id, name, emoji, status, current_task, autonomy_level, model) VALUES
  ('chief-of-staff', 'Chief of Staff', '🎭', 'active', 'Building Mission Control dashboard', 'recommend', 'opus'),
  ('head-of-sales', 'Head of Sales', '💼', 'idle', 'Pipeline: 4 active leads', 'recommend', 'sonnet'),
  ('cto', 'CTO', '⚙️', 'active', 'Monitoring systems', 'autonomous', 'opus'),
  ('chief-life-officer', 'Chief Life Officer', '🧘', 'idle', 'Weekly check-in pending', 'alert-only', 'sonnet')
ON CONFLICT (id) DO NOTHING;
