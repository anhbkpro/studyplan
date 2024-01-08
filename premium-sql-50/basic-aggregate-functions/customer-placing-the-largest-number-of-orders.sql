select customer_number
from
(
    select customer_number, COUNT(*) as num_orders
    from orders
    group by 1
) t
order by num_orders desc
limit 1
