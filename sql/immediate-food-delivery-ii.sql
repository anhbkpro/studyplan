select ROUND(avg(
    case
        when r.order_date = r.customer_pref_delivery_date then 1
        else 0
    end
) * 100, 2) as immediate_percentage from
(select *,
DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY order_date) as rnk
from delivery) r
where r.rnk = 1
