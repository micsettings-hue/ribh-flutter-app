-- M6: auto-invest consent rail.
--
-- Approval and deployment are ONE transaction: approve_queue_item marks the
-- item approved and invests through invest_in_campaign together, so a retry
-- can never double-deploy and an approved item without its investment cannot
-- exist. Declining moves no money and stays a plain status update under the
-- existing RLS policy. Nothing deploys while pending.

-- Approves one pending queue item owned by the caller and deploys the
-- rule's budget into the item's campaign. Both risk acknowledgements are
-- required here exactly as in a manual investment; invest_in_campaign
-- re-checks them along with KYC, campaign status, pool headroom, and the
-- derived balance.
create function public.approve_queue_item(
  p_item_id uuid,
  p_ack1 boolean,
  p_ack2 boolean
)
returns uuid
language plpgsql
security definer
set search_path = public
as $$
declare
  v_profile_id uuid := auth.uid();
  v_item public.auto_invest_queue%rowtype;
  v_rule public.auto_invest_rules%rowtype;
  v_investment_id uuid;
begin
  if v_profile_id is null then
    raise exception 'not_authenticated' using errcode = 'P0001';
  end if;

  select q.* into v_item
    from public.auto_invest_queue q
    join public.auto_invest_rules r on r.id = q.rule_id
    where q.id = p_item_id and r.profile_id = v_profile_id
    for update of q;
  if v_item.id is null then
    raise exception 'queue_item_not_found' using errcode = 'P0001';
  end if;
  if v_item.status <> 'pending' then
    raise exception 'request_not_pending' using errcode = 'P0001';
  end if;

  select * into v_rule
    from public.auto_invest_rules where id = v_item.rule_id;
  if not v_rule.active then
    raise exception 'rule_inactive' using errcode = 'P0001';
  end if;

  -- One transaction: the investment (and its ledger row) plus the status
  -- move commit or roll back together.
  v_investment_id := public.invest_in_campaign(
    v_item.campaign_id, v_rule.budget, p_ack1, p_ack2, 'auto_invest');

  update public.auto_invest_queue
    set status = 'approved'
    where id = p_item_id;

  return v_investment_id;
end;
$$;

grant execute on function public.approve_queue_item(uuid, boolean, boolean)
  to authenticated;

-- System-side proposal pass, service_role only (queue items are inserted by
-- the system, never by clients). For every active rule, proposes open
-- campaigns that match the strategy and are not already queued for or held
-- under that rule. Strategy match:
--   short:       tenure <= 6 months
--   balanced:    risk in ('low', 'moderate')
--   diversified: any open campaign
create function public.propose_queue_items()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  v_inserted integer;
begin
  with proposals as (
    select r.id as rule_id, c.id as campaign_id
    from public.auto_invest_rules r
    join public.campaigns c on c.status = 'open'
    where r.active
      and case r.strategy
            when 'short' then c.tenure <= 6
            when 'balanced' then c.risk in ('low', 'moderate')
            else true
          end
      and not exists (
        select 1 from public.auto_invest_queue q
        where q.rule_id = r.id and q.campaign_id = c.id
      )
      and not exists (
        select 1 from public.investments i
        where i.profile_id = r.profile_id and i.campaign_id = c.id
      )
  )
  insert into public.auto_invest_queue (rule_id, campaign_id)
    select rule_id, campaign_id from proposals;
  get diagnostics v_inserted = row_count;
  return v_inserted;
end;
$$;

revoke execute on function public.propose_queue_items()
  from public, anon, authenticated;
grant execute on function public.propose_queue_items() to service_role;
