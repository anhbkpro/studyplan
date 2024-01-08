select seller_name
from seller
where seller_id not in
(
    select seller_id
    from seller
    left join orders
    using (seller_id)
    where YEAR(sale_date) = '2020'
)
order by 1
