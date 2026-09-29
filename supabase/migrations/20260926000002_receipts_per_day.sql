-- Several receipts per day (split bills, a second round). The first receipt of the
-- day at a bar is the visit: fixed XP, streak, visit count. Further receipts that
-- day join that visit and only add coins (same formula, same daily coin cap), so XP
-- never grows with spending. receipt_daily_limit stays as an abuse guard.
alter table economy_config alter column receipt_daily_limit set default 10;
update economy_config set receipt_daily_limit = 10 where receipt_daily_limit < 10;

create or replace function add_receipt_to_visit(p_user uuid, p_visit uuid, p_amount_cents int)
returns int language plpgsql security definer set search_path = public as $$
declare
  cfg economy_config; p profiles; v visits; v_mult numeric; v_coins int; v_today int;
begin
  select * into cfg from economy_config where id = 1;
  select * into p from profiles where id = p_user for update;
  select * into v from visits where id = p_visit and user_id = p_user for update;
  if v.id is null then raise exception 'unknown visit'; end if;

  update visits set amount_cents = amount_cents + p_amount_cents where id = p_visit;

  select coin_multiplier into v_mult from levels where level = p.level;
  v_coins := floor(cfg.coins_per_euro * (p_amount_cents / 100.0) * coalesce(v_mult, 1));
  select coalesce(sum(cl.amount), 0) into v_today
    from coin_ledger cl join visits vi on vi.id::text = cl.ref_id
    where cl.user_id = p_user and cl.reason = 'visit' and cl.amount > 0
      and (vi.visited_at at time zone 'Europe/Berlin')::date = (v.visited_at at time zone 'Europe/Berlin')::date;
  v_coins := least(v_coins, greatest(cfg.daily_coin_cap - v_today, 0));
  perform add_coins(p_user, v_coins, 'visit', p_visit::text);

  perform notify(p_user, 'visit_credited', 'Beleg hinzugefügt', 'Receipt added',
    '+' || v_coins || ' Münzen zu deinem heutigen Besuch', '+' || v_coins || ' coins for today''s visit',
    jsonb_build_object('visit_id', p_visit, 'xp', 0, 'coins', v_coins));
  perform check_achievements(p_user);
  return v_coins;
end $$;

revoke execute on function add_receipt_to_visit(uuid, uuid, int) from public, anon, authenticated;

create or replace function redeem_receipt(p_payload text)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  cfg economy_config; v_uid uuid := auth.uid(); v_parts text[]; v_serial text; v_tx text; v_data text;
  v_amounts text; v_amount numeric := 0; v_part text; v_at timestamptz; v_venue uuid; v_cents int;
  v_code receipt_codes; v_kind text; v_today int; v_visit uuid; v_added boolean := false; p profiles; q profiles;
begin
  if v_uid is null then raise exception 'not authenticated'; end if;
  select * into cfg from economy_config where id = 1;
  p_payload := trim(coalesce(p_payload, ''));
  if p_payload = '' then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;

  if p_payload like 'V0;%' then
    v_kind := 'tse';
    v_parts := string_to_array(p_payload, ';');
    if array_length(v_parts, 1) < 8 then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    v_serial := v_parts[2];
    v_data := v_parts[4];
    v_tx := v_parts[5];
    begin
      v_at := v_parts[7]::timestamptz;
    exception when others then
      raise exception 'RECEIPT_INVALID' using errcode = 'P0001';
    end;
    -- processData "Beleg^<gross per VAT rate, _-separated>^<payments>"
    v_amounts := split_part(v_data, '^', 2);
    if v_amounts = '' then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    foreach v_part in array string_to_array(v_amounts, '_') loop
      if v_part ~ '^-?[0-9]+(\.[0-9]+)?$' then v_amount := v_amount + v_part::numeric; end if;
    end loop;
    v_cents := round(v_amount * 100);
    select venue_id into v_venue from venue_registers where serial = v_serial;
    if v_venue is null then raise exception 'RECEIPT_UNKNOWN_VENUE' using errcode = 'P0001'; end if;
    if v_at > now() + interval '10 minutes' then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    if cfg.receipt_max_age_hours > 0 and v_at < now() - make_interval(hours => cfg.receipt_max_age_hours) then
      raise exception 'RECEIPT_TOO_OLD' using errcode = 'P0001';
    end if;
  else
    v_kind := 'code';
    v_tx := upper(regexp_replace(p_payload, '^(VH:|vh:)', ''));
    v_tx := regexp_replace(v_tx, '[^A-Z0-9-]', '', 'g');
    select * into v_code from receipt_codes where code = v_tx for update;
    if v_code.code is null then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    if v_code.used_at is not null then raise exception 'RECEIPT_USED' using errcode = 'P0001'; end if;
    if v_code.expires_at is not null and v_code.expires_at < now() then raise exception 'RECEIPT_TOO_OLD' using errcode = 'P0001'; end if;
    v_venue := v_code.venue_id;
    v_cents := v_code.amount_cents;
    v_at := now();
  end if;

  if v_cents <= 0 or v_cents > 100000 then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
  if exists (select 1 from receipts where kind = v_kind and register_serial is not distinct from v_serial and transaction_no = v_tx) then
    raise exception 'RECEIPT_USED' using errcode = 'P0001';
  end if;
  select count(*) into v_today from receipts
    where user_id = v_uid and venue_id = v_venue
      and (created_at at time zone 'Europe/Berlin')::date = (now() at time zone 'Europe/Berlin')::date;
  if v_today >= cfg.receipt_daily_limit then raise exception 'RECEIPT_DAILY_LIMIT' using errcode = 'P0001'; end if;

  select * into p from profiles where id = v_uid;
  -- the first receipt of the day is the visit (XP, streak); later ones join it and only add coins
  select visit_id into v_visit from receipts
    where user_id = v_uid and venue_id = v_venue and visit_id is not null
      and (created_at at time zone 'Europe/Berlin')::date = (now() at time zone 'Europe/Berlin')::date
    order by created_at limit 1;
  if v_visit is not null then
    perform add_receipt_to_visit(v_uid, v_visit, v_cents);
    v_added := true;
  else
    v_visit := record_visit(v_uid, v_venue, v_cents, 'receipt', null, v_uid, least(v_at, now()));
  end if;
  insert into receipts (user_id, venue_id, kind, register_serial, transaction_no, amount_cents, receipt_at, visit_id)
  values (v_uid, v_venue, v_kind, v_serial, v_tx, v_cents, v_at, v_visit);
  if v_kind = 'code' then update receipt_codes set used_by = v_uid, used_at = now() where code = v_tx; end if;
  select * into q from profiles where id = v_uid;

  return jsonb_build_object(
    'visit_id', v_visit, 'venue_id', v_venue, 'amount_cents', v_cents,
    'xp_gained', q.xp - p.xp, 'coins_gained', q.coin_balance - p.coin_balance,
    'level_before', p.level, 'level_after', q.level, 'streak_weeks', q.current_streak_weeks,
    'added_to_visit', v_added,
    -- unlocked by this very transaction
    'achievements', (select coalesce(jsonb_agg(achievement_key), '[]'::jsonb) from user_achievements
                     where user_id = v_uid and unlocked_at = now()));
end $$;
