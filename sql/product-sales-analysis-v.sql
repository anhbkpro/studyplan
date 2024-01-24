select user_id, SUM(quantity * price) as spending
from sales
join product
using (product_id)
group by 1
order by 2 desc, 1
