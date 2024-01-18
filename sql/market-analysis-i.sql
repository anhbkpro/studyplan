with ordered as
(
    select user_id as buyer_id,
    join_date,
    COUNT(order_id) as orders_in_2019
    from users u
    inner join orders o
    on u.user_id = o.buyer_id
    where YEAR(o.order_date) = 2019
    group by buyer_id
),
no_ordered as
(
    select user_id as buyer_id,
    join_date,
    0 as orders_in_2019
    from users
    where user_id not in (select buyer_id from ordered)
)
select * from no_ordered
union all
select * from ordered
