select customer_id, product_id, product_name
from
(
    select customer_id, product_id,
        DENSE_RANK() over (PARTITION BY customer_id order by prods desc) as rnk
    from
    (
        select *, COUNT(product_id) as prods
        from orders
        group by customer_id, product_id
    ) g
) f
join products
using (product_id)
where f.rnk = 1
