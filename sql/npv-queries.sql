with years as
(
    select year from npv
)
select q.id, q.year,
    IFNULL(
        CASE
            WHEN q.year in (select * from years) then n.npv
            ELSE 0
        END,
        0
    ) as npv
from queries q
left outer join npv n
using (id, year)
