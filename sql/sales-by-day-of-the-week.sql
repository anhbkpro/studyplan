select item_category as CATEGORY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 2 THEN quantity END), 0) as MONDAY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 3 THEN quantity END), 0) as TUESDAY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 4 THEN quantity END), 0) as WEDNESDAY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 5 THEN quantity END), 0) as THURSDAY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 6 THEN quantity END), 0) as FRIDAY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 7 THEN quantity END), 0) as SATURDAY,
    IFNULL(SUM(CASE WHEN dayofweek(order_date) = 1 THEN quantity END), 0) as SUNDAY
from items
left join orders using(item_id)
group by item_category
order by item_category
