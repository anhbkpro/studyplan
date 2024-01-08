select name
from salesperson
where sales_id not in
(
    select s.sales_id
    from salesperson s
    join orders o
    using (sales_id)
    join company c
    using (com_id)
    where c.name = 'RED'
)
