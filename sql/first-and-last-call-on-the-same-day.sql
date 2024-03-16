-- cte to create a unified view of all calls, treating each user as a 'participant'
with unified_calls as (
  -- include calls where the user is the caller
  select
    caller_id as user_id,
    call_time,
    recipient_id as other_participant_id
  from
    calls
  union
    -- include calls where the user is the recipient
  select
    recipient_id as user_id,
    call_time,
    caller_id as other_participant_id
  from
    calls
),
-- cte to rank the calls for each user on each day
ranked_calls as (
  select
    user_id,
    other_participant_id,
    date(call_time) as call_date,
    -- extracting just the date part of call_time
    dense_rank() over (
      partition by user_id,
      date(call_time)
      order by
        call_time asc
    ) as rank_earliest_call,
    dense_rank() over (
      partition by user_id,
      date(call_time)
      order by
        call_time desc
    ) as rank_latest_call
  from
    unified_calls
) -- selecting users whose first and last calls of the day were with the same person

select
  distinct user_id
from
  ranked_calls
where
  rank_earliest_call = 1
  or rank_latest_call = 1 -- filtering for first and last calls
group by
  user_id,
  call_date
having
  count(distinct other_participant_id) = 1;
