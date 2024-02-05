with out_txes as (
    select user_id, credit, IFNULL(SUM(amount), 0) as total
    from users u
    join transactions t
    on t.paid_by = u.user_id
    group by 1
),
in_txes as (
    select user_id, credit, IFNULL(SUM(amount), 0) as total
    from users u
    join transactions t
    on t.paid_to = u.user_id
    group by 1
)

select
    u.user_id,
    u.user_name,
    (u.credit - IFNULL(ot.total, 0) + IFNULL(it.total, 0)) as credit,
    case
        when (u.credit - IFNULL(ot.total, 0) + IFNULL(it.total, 0)) < 0 then 'Yes'
        else 'No'
    end as credit_limit_breached
from users u
left join out_txes ot
using (user_id)
left join in_txes it
using (user_id)
