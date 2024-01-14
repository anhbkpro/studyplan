with all_dates as(
    select user_id, visit_date
    from uservisits
    union
    select user_id, '2021-01-01' as 'visit_date'
    from uservisits)
, rnk AS(
    select *,
        RANK() OVER (PARTITION BY user_id order by visit_date) as date_rnk
    from all_dates
)
select a.user_id, MAX(DATEDIFF(b.visit_date, a.visit_date)) as biggest_window
from rnk a, rnk b
where a.user_id = b.user_id
and b.date_rnk = a.date_rnk + 1
group by a.user_id
