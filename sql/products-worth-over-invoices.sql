select name,
    IFNULL(SUM(rest), 0) as rest,
    IFNULL(SUM(paid), 0) as paid,
    IFNULL(SUM(canceled), 0) as canceled,
    IFNULL(SUM(refunded), 0) as refunded
from product
left join invoice
using (product_id)
group by 1
order by 1
