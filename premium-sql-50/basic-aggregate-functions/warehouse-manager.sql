select name as warehouse_name,
    SUM(units * Width * Length * Height) as volume
from warehouse
join products
using (product_id)
group by 1
