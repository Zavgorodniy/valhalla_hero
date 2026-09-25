-- Valhalla Hero: row level security
set search_path = public;

alter table venues enable row level security;
alter table economy_config enable row level security;
alter table levels enable row level security;
alter table profiles enable row level security;
alter table venue_staff enable row level security;
alter table device_tokens enable row level security;
alter table visit_claims enable row level security;
alter table visits enable row level security;
alter table xp_ledger enable row level security;
alter table coin_ledger enable row level security;
alter table achievements enable row level security;
alter table user_achievements enable row level security;
alter table items enable row level security;
alter table user_items enable row level security;
alter table equipment enable row level security;
alter table rewards enable row level security;
alter table vouchers enable row level security;
alter table posts enable row level security;
alter table post_likes enable row level security;
alter table notifications enable row level security;

-- reference data: readable by everyone signed in, writable by admins
create policy venues_read on venues for select to authenticated using (true);
create policy venues_admin on venues for all to authenticated using (is_admin()) with check (is_admin());

create policy config_read on economy_config for select to authenticated using (true);
create policy config_admin on economy_config for update to authenticated using (is_admin()) with check (is_admin());

create policy levels_read on levels for select to authenticated using (true);
create policy levels_admin on levels for all to authenticated using (is_admin()) with check (is_admin());

create policy achievements_read on achievements for select to authenticated using (true);
create policy achievements_admin on achievements for all to authenticated using (is_admin()) with check (is_admin());

create policy items_read on items for select to authenticated using (is_active or is_staff());
create policy items_admin on items for all to authenticated using (is_admin()) with check (is_admin());

create policy rewards_read on rewards for select to authenticated using (is_active or is_staff());
create policy rewards_admin on rewards for all to authenticated using (is_admin()) with check (is_admin());

-- profiles: own row fully, staff read all, admin update role
create policy profiles_own_read on profiles for select to authenticated using (id = auth.uid() or is_staff());
create policy profiles_own_update on profiles for update to authenticated
  using (id = auth.uid())
  with check (id = auth.uid() and role = (select role from profiles p2 where p2.id = auth.uid()) and xp = (select xp from profiles p3 where p3.id = auth.uid()) and coin_balance = (select coin_balance from profiles p4 where p4.id = auth.uid()));
create policy profiles_admin_update on profiles for update to authenticated using (is_admin()) with check (is_admin());

create policy venue_staff_read on venue_staff for select to authenticated using (user_id = auth.uid() or is_admin());
create policy venue_staff_admin on venue_staff for all to authenticated using (is_admin()) with check (is_admin());

create policy device_tokens_own on device_tokens for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

-- claims: users see own, staff see all (inserts only via submit_visit_claim RPC)
create policy claims_read on visit_claims for select to authenticated using (user_id = auth.uid() or is_staff());

create policy visits_read on visits for select to authenticated using (user_id = auth.uid() or is_staff());
create policy xp_ledger_read on xp_ledger for select to authenticated using (user_id = auth.uid() or is_staff());
create policy coin_ledger_read on coin_ledger for select to authenticated using (user_id = auth.uid() or is_staff());

create policy user_achievements_read on user_achievements for select to authenticated using (user_id = auth.uid() or is_staff());
create policy user_items_read on user_items for select to authenticated using (user_id = auth.uid() or is_staff());
create policy equipment_read on equipment for select to authenticated using (true);

create policy vouchers_read on vouchers for select to authenticated using (user_id = auth.uid() or is_staff());

-- feed
create policy posts_read on posts for select to authenticated using (published_at is not null or is_manager());
create policy posts_manage on posts for all to authenticated using (is_manager()) with check (is_manager());
create policy post_likes_read on post_likes for select to authenticated using (true);

create policy notifications_own on notifications for select to authenticated using (user_id = auth.uid());
create policy notifications_mark_read on notifications for update to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());

-- views & grants
grant select on public_profiles to authenticated;
grant usage on schema public to authenticated, anon;

-- scheduled jobs (pg_cron ships with Supabase; ignore if unavailable locally)
do $$
begin
  create extension if not exists pg_cron;
  perform cron.schedule('expire-coins', '15 3 * * *', 'select public.expire_coins()');
  perform cron.schedule('notify-expiring-coins', '0 10 * * *', 'select public.notify_expiring_coins()');
exception when others then
  raise notice 'pg_cron not available: %', sqlerrm;
end $$;
