select DATE_FORMAT(order_date, "%Y-%m") as month,
    COUNT(distinct order_id) as order_count,
    COUNT(distinct customer_id) as customer_count
from orders
where invoice > 20
group by 1
