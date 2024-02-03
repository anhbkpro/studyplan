select
    SUM(b.apple_count + IFNULL(c.apple_count, 0)) as apple_count,
    SUM(b.orange_count + IFNULL(c.orange_count, 0)) as orange_count
from boxes b
left join chests c
using (chest_id)
