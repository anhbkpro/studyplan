select u.user_id as seller_id,
       case when u.favorite_brand = b.item_brand then 'yes' else 'no' end as 2nd_item_fav_brand
from users u
left join (
    select a.seller_id, a.item_id, i.item_brand
    from (
        select seller_id,
               item_id,
               RANK() OVER (PARTITION BY seller_id ORDER BY order_date asc) as rnk
        from orders) a
    join items i
    using (item_id)
    where a.rnk = 2) b
on u.user_id = b.seller_id
