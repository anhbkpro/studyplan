select lower(trim(product_name)) as product_name, DATE_FORMAT(sale_date, "%Y-%m") as sale_date, COUNT(sale_id) as total
from sales
group by 1, 2
order by 1, 2
