select visits.visited_on as visited_on, SUM(c.amount) as amount,
    ROUND(SUM(c.amount) / 7.0, 2) as average_amount
from (
    select DISTINCT visited_on
    from customer
    where DATEDIFF(visited_on, (select MIN(visited_on) from customer)) >= 6
) visits
left join customer c
on DATEDIFF(visits.visited_on, c.visited_on) between 0 and 6
group by visits.visited_on
order by visited_on;
