with min_data as
(
  select player_id,
    MIN(event_date) as event_date
  from activity
  group by 1
)
select player_id, device_id
from activity a
inner join min_data m
using (event_date, player_id)
