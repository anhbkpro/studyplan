select user_id, COUNT(follower_id) as followers_count
from followers
group by 1
order by 1
