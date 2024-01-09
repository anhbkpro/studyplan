select customer_id, name
from
(
    select customer_id, name, CONCAT(YEAR(order_date), '-', MONTH(order_date)) as month
    from customers
    left join orders o
    using (customer_id)
    left join product p
    using (product_id)
    group by customer_id, CONCAT(YEAR(order_date), MONTH(order_date))
    HAVING (SUM(p.price * o.quantity)) >= 100
) g
where month in ('2020-7', '2020-6')
group by 1
HAVING COUNT(*) = 2
