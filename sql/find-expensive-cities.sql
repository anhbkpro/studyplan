with avg_price as (
    select AVG(price)
    from listings
)
select distinct city
from listings
group by city
having AVG(price) > (select * from avg_price)
order by 1
