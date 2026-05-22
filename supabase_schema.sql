-- =============================================
-- IMPÉRIO — Dólar Club | Supabase Schema
-- Execute no SQL Editor do Supabase
-- =============================================

create table if not exists imperio_config (
  id uuid primary key default gen_random_uuid(),
  saldo numeric(14,2) not null default 0,
  criado_em timestamptz default now(),
  atualizado_em timestamptz default now()
);

create table if not exists aportes (
  id uuid primary key default gen_random_uuid(),
  valor numeric(14,2) not null,
  descricao text,
  mes text,
  criado_em timestamptz default now()
);

create table if not exists retiradas (
  id uuid primary key default gen_random_uuid(),
  valor numeric(14,2) not null,
  descricao text,
  mes text,
  status text not null default 'pendente' check (status in ('pendente','confirmada','cancelada')),
  criado_em timestamptz default now()
);

create table if not exists metas (
  id uuid primary key default gen_random_uuid(),
  nome text not null,
  objetivo numeric(14,2) not null,
  atual numeric(14,2) not null default 0,
  prazo text,
  concluida boolean default false,
  criado_em timestamptz default now(),
  atualizado_em timestamptz default now()
);

create table if not exists historico (
  id uuid primary key default gen_random_uuid(),
  mes text not null,
  saldo numeric(14,2) not null,
  criado_em timestamptz default now()
);

-- Inserir config inicial
insert into imperio_config (saldo) values (0)
on conflict do nothing;

-- RLS: desabilitar para uso pessoal (ou configurar conforme necessário)
alter table imperio_config enable row level security;
alter table aportes enable row level security;
alter table retiradas enable row level security;
alter table metas enable row level security;
alter table historico enable row level security;

-- Policies públicas (para uso pessoal sem auth)
create policy "allow all" on imperio_config for all using (true) with check (true);
create policy "allow all" on aportes for all using (true) with check (true);
create policy "allow all" on retiradas for all using (true) with check (true);
create policy "allow all" on metas for all using (true) with check (true);
create policy "allow all" on historico for all using (true) with check (true);
