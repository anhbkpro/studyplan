with DaysOfWeekOrders as(
    select item_category as CATEGORY,
    IFNULL(CASE WHEN day_of_week = 2 THEN SUM(quantity) END, 0) as MONDAY,
    IFNULL(CASE WHEN day_of_week = 3 THEN SUM(quantity) END, 0) as TUESDAY,
    IFNULL(CASE WHEN day_of_week = 4 THEN SUM(quantity) END, 0) as WEDNESDAY,
    IFNULL(CASE WHEN day_of_week = 5 THEN SUM(quantity) END, 0) as THURSDAY,
    IFNULL(CASE WHEN day_of_week = 6 THEN SUM(quantity) END, 0) as FRIDAY,
    IFNULL(CASE WHEN day_of_week = 7 THEN SUM(quantity) END, 0) as SATURDAY,
    IFNULL(CASE WHEN day_of_week = 1 THEN SUM(quantity) END, 0) as SUNDAY
    from
    (
        select order_id, customer_id, order_date, o.item_id, quantity, i.item_category,
            -- 1 = Sunday
            -- 2 = Monday
            -- ...
            -- 7 = Satuday
            dayofweek(order_date) as day_of_week
        from orders o
        right join items i on i.item_id = o.item_id
    ) j
    group by item_category, day_of_week
    order by item_category
)

select CATEGORY,
    MAX(MONDAY) as MONDAY,
    MAX(TUESDAY) as TUESDAY,
    MAX(WEDNESDAY) as WEDNESDAY,
    MAX(THURSDAY) as THURSDAY,
    MAX(FRIDAY) as FRIDAY,
    MAX(SATURDAY) as SATURDAY,
    MAX(SUNDAY) as SUNDAY
from DaysOfWeekOrders
group by 1
