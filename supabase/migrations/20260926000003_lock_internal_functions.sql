-- Internal SECURITY DEFINER helpers must not be callable through the API.
-- Postgres grants EXECUTE to PUBLIC by default, so e.g. any signed-in guest could
-- call rpc('add_coins', …) and mint coins. Only the app-facing RPCs stay open;
-- is_staff/is_admin/is_manager/manages_venue/role_of stay open for RLS policies.
do $$
declare f regprocedure;
begin
  for f in
    select p.oid::regprocedure from pg_proc p join pg_namespace n on n.oid = p.pronamespace
    where n.nspname = 'public' and p.proname in (
      'add_coins', 'spend_coins', 'add_xp', 'record_visit', 'add_receipt_to_visit',
      'grant_achievement', 'check_achievements', 'check_checkin_achievements',
      'notify', 'expire_coins', 'notify_expiring_coins', 'handle_new_user')
  loop
    execute format('revoke execute on function %s from public, anon, authenticated', f);
  end loop;
end $$;
