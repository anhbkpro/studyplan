select q.id, q.year,
    IFNULL(n.npv, 0) AS npv -- or COALESCE(n.npv, 0) AS npv
from queries q
left outer join npv n
using (id, year)
