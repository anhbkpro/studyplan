select MAX(g.num) as num
from
(select num, COUNT(num) as count
from mynumbers
group by 1) as g
where g.count = 1
