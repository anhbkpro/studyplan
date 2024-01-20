select ad_id,
        ROUND(
            IFNULL(
                (SUM(action = 'Clicked')/(SUM(action = 'Clicked') + SUM(action = 'Viewed'))) * 100,
            0)
        ,
        2) as ctr
from ads
group by 1
order by 2 desc, 1
