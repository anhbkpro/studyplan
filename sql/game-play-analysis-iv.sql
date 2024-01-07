with total_user as
(
    select COUNT(distinct player_id) from activity
),
min_dates as
(
    select
      player_id,
      MIN(event_date)
    from activity
    group by 1
)
select
  ROUND(COUNT(a1.player_id) / (select * from total_user), 2) as fraction
from
  activity a
where
    (a.player_id, DATE_SUB(a.event_date, INTERVAL 1 DAY)) in (
        select * from min_dates
    );
