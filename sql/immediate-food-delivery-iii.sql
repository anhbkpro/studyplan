select order_date, ROUND(avg(case when order_date = customer_pref_delivery_date then 1 else 0 end) * 100, 2) as immediate_percentage
from delivery
group by 1
order by 1
