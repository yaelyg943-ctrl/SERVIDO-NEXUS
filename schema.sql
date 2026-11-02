-- NexusPreds Control Center | Esquema inicial para Supabase
-- Ejecuta TODO este archivo en Supabase > SQL Editor > New query.
create extension if not exists pgcrypto;

create table if not exists public.np_accounts (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 service text not null,
 mode text not null default 'Cuenta completa',
 profile text,
 owner_type text not null default 'Propia',
 supplier text,
 status text not null default 'Activo',
 customer text not null,
 phone text not null,
 login_email text,
 login_password text,
 start_date date not null,
 expiry_date date not null,
 cost_price numeric(12,2) not null default 0,
 sale_price numeric(12,2) not null default 0,
 warranty text,
 notes text,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create table if not exists public.np_movements (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 movement_type text not null check (movement_type in ('Entrada','Salida')),
 movement_date date not null default current_date,
 concept text not null,
 amount numeric(12,2) not null check (amount >= 0),
 account_id uuid references public.np_accounts(id) on delete set null,
 note text,
 created_at timestamptz not null default now()
);
create table if not exists public.np_suppliers (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
 name text not null,
 phone text,
 email text,
 service text,
 notes text,
 created_at timestamptz not null default now()
);
alter table public.np_accounts enable row level security;
alter table public.np_movements enable row level security;
alter table public.np_suppliers enable row level security;

drop policy if exists "accounts own rows" on public.np_accounts;
create policy "accounts own rows" on public.np_accounts for all to authenticated
 using (user_id = auth.uid()) with check (user_id = auth.uid());
drop policy if exists "movements own rows" on public.np_movements;
create policy "movements own rows" on public.np_movements for all to authenticated
 using (user_id = auth.uid()) with check (user_id = auth.uid());
drop policy if exists "suppliers own rows" on public.np_suppliers;
create policy "suppliers own rows" on public.np_suppliers for all to authenticated
 using (user_id = auth.uid()) with check (user_id = auth.uid());

create index if not exists np_accounts_user_expiry_idx on public.np_accounts(user_id, expiry_date);
create index if not exists np_movements_user_date_idx on public.np_movements(user_id, movement_date desc);
create index if not exists np_suppliers_user_name_idx on public.np_suppliers(user_id, name);
