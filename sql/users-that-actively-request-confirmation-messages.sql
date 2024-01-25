select distinct user_id
from
(
    select user_id, time_stamp,
        LEAD(time_stamp) OVER (PARTITION BY user_id ORDER BY time_stamp) as next_request
    from confirmations
) as l
where timestampdiff(second, l.time_stamp, l.next_request) <= 24*60*60
