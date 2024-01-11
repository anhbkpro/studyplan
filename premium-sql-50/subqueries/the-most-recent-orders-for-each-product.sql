with recent_orders as
(
    select order_id,
        product_id,
        order_date,
        DENSE_RANK() OVER (PARTITION BY product_id order by order_date desc) as rnk
    from orders
)
select product_name, product_id, order_id, order_date
from products
join recent_orders ro
using (product_id)
where ro.rnk = 1
order by 1, 2, 3
