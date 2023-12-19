select r.contest_id, ROUND(100 * count(r.user_id)/(select count(user_id) from users), 2) as percentage
from register r
left join users u
on r.user_id = u.user_id
group by r.contest_id
order by percentage desc, r.contest_id
