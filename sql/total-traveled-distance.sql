select user_id, name, SUM(IFNULL(distance, 0)) as 'traveled distance'
from users
left join rides
using (user_id)
group by 1
order by 1
