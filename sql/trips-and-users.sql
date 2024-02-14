with trip_status as (
  select
    request_at as day,
    t.status != 'completed' as cancelled
  from
    trips t
    join users c on client_id = c.users_id
    and c.banned = 'no'
    join users d on driver_id = d.users_id
    and d.banned = 'no'
  where
    request_at between '2013-10-01' and '2013-10-03'
)
select
  day,
  round(
    sum(cancelled) / count(cancelled),
    2
  ) as 'cancellation rate'
from
  trip_status
group by
  day;
