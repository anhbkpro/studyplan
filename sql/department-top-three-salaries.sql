with employee_ranked as (
    select d.id,
        d.name as Department,
        salary as Salary,
        e.name as Employee,
        DENSE_RANK()OVER(PARTITION BY d.id order by salary desc) as rnk
    from department d
    join employee e
    on d.id = e.departmentId
)
select Department,
    Employee,
    Salary
from employee_ranked
where rnk <= 3
order by 1
