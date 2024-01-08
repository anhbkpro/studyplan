with from_to as
(
    select *
    from calls
    where from_id < to_id
),
to_from as
(
    select *
    from calls
    where from_id > to_id
)
select from_id as person1, to_id as person2,
COUNT(*) as call_count,
SUM(duration) as total_duration
from
(
    select from_id, to_id, duration from from_to
    UNION ALL
    select to_id as from_id, from_id as to_id, duration from to_from
) t
group by from_id, to_id
