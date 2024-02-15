select
    e1.id,
    e1.month,
    (IFNULL(e1.salary, 0) + IFNULL(e2.salary, 0) + IFNULL(e3.salary, 0)) as salary
from
    (select
        id, MAX(month) as month
    from
        employee
    group by id
    having COUNT(*) > 1) as maxmonth
        left join
    employee e1 on (maxmonth.id = e1.id
        and maxmonth.month > e1.month)
        left join
    employee e2 on (e2.id = e1.id
        and e2.month = e1.month - 1)
        left join
    employee e3 on (e3.id = e1.id
        and e3.month = e1.month - 2)
order by id asc , month desc
;
