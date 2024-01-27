select name as follower, COUNT(*) as num
from
(
    select f1.followee as name
    from follow f1
    where f1.followee in (select f2.follower from follow f2)
) g
group by 1
order by 1
