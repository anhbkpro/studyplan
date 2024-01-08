with g as
(
    select customer_id,
        GROUP_CONCAT(distinct product_name order by product_name separator '') as products
    from orders
    group by customer_id
)
select c.customer_id, c.customer_name from g
join customers c
using (customer_id)
where g.products like 'AB%' and g.products not like 'ABC%'
