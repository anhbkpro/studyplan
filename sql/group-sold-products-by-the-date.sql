select
    sell_date,
    COUNT(DISTINCT(product)) as num_sold,
    GROUP_CONCAT(DISTINCT product order by product SEPARATOR ',') as products
from
    activities
group by 1
order by 1
