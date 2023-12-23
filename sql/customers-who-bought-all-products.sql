select customer_id
from
(
    select customer_id, count(distinct(product_key)) as cnt
    from customer
    group by 1
) as g
where g.cnt >= (select count(*) from product)
