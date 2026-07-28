-- ============================================================
-- Mukund Online Classes — Supabase Database Setup
-- Run this ENTIRE script once in: Supabase Dashboard → SQL Editor → New query → Run
-- ============================================================

-- 1. Create tables (each row = one record, stored as flexible JSON in "data")
create table if not exists pcb_users (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

create table if not exists pcb_sessions (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

create table if not exists pcb_scheduled_classes (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

create table if not exists pcb_notifications (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

create table if not exists pcb_settings (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

-- 2. Enable Row Level Security (required by Supabase)
alter table pcb_users enable row level security;
alter table pcb_sessions enable row level security;
alter table pcb_scheduled_classes enable row level security;
alter table pcb_notifications enable row level security;
alter table pcb_settings enable row level security;

-- 3. Allow the app (using the public anon key) to read/write.
--    NOTE: this means anyone with your site's URL can technically
--    read/write this data via the anon key, same trust model as the
--    "test mode" Firebase setup. Fine for getting started; tighten
--    later with real user auth if you want stricter control.
create policy "Allow public access" on pcb_users for all using (true) with check (true);
create policy "Allow public access" on pcb_sessions for all using (true) with check (true);
create policy "Allow public access" on pcb_scheduled_classes for all using (true) with check (true);
create policy "Allow public access" on pcb_notifications for all using (true) with check (true);
create policy "Allow public access" on pcb_settings for all using (true) with check (true);

-- 4. Turn on real-time sync for each table
alter publication supabase_realtime add table pcb_users;
alter publication supabase_realtime add table pcb_sessions;
alter publication supabase_realtime add table pcb_scheduled_classes;
alter publication supabase_realtime add table pcb_notifications;
alter publication supabase_realtime add table pcb_settings;
