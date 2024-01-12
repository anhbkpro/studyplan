select name as customer_name, customer_id, order_id, order_date
from
(
    select name , customer_id, order_id, order_date,
        DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY order_date desc) as rnk
    from customers
    join orders
    using (customer_id)
) t
where t.rnk <= 3
order by 1, 2, 4 desc
