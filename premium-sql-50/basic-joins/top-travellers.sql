select name,
IFNULL(sum(r.distance), 0) as travelled_distance --  for users who do not have any rides, use IFNULL() or COALESCE() to return 0 for their distance
from users u
left join rides r
on u.id = r.user_id
group by u.id
order by 2 desc, 1
