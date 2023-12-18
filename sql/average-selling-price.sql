select
    p.product_id,
    IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price
from
    prices AS p
left join
    unitssold AS u
on
    p.product_id = u.product_id
    and u.purchase_date between p.start_date and p.end_date
group by
    p.product_id;
