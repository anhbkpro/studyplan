with cte as (
    select '[0-5>' AS bin, 0 as min_duration, 5*60 as max_duration
    UNION ALL
    select '[5-10>' AS bin, 5*60 as min_duration, 10*60 as max_duration
    UNION ALL
    select '[10-15>' AS bin, 10*60 as min_duration, 15*60 as max_duration
    UNION ALL
    select '15 or more' AS bin, 15*60 as min_duration, 2147483647 as max_duration
)

select cte.bin, COUNT(s.session_id) as total
from sessions s
right join cte
    on s.duration >= min_duration
    and s.duration < max_duration
group by cte.bin
