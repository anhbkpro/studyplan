select login_date, count(1) user_count
from
(
  select user_id, MIN(activity_date) as login_date
  from traffic
  where activity = 'login'
  group by 1
) a
where (login_date between DATE_ADD('2019-06-30', interval -90 day) and '2019-06-30')
group by 1
