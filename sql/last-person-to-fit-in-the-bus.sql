select person_name
from (
    select *,
    sum(weight) over(order by turn) as sum_weight
    from queue
    ) a
where sum_weight <= 1000
order by turn desc
limit 1
