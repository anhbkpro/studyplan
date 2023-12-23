select MAX(g.num) as num
from
(select num, COUNT(num) as count
from mynumbers
group by 1) as g
where g.count = 1

-- using HAVING
with f as (
    select num
    from mynumbers
    group by 1
    having COUNT(num) = 1
)
select MAX(f.num) as num
from f

-- using window function
with f as (
    select num, COUNT(num) over (partition by num) as count
    from mynumbers
)
select MAX(f.num) as num
from f
where f.count = 1
