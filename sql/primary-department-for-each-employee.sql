-- Approach 1: UNION
with exact_once as (
    select employee_id, department_id
    from employee
    group by 1
    having COUNT(employee_id) = 1
),
prim_emp as (
    select employee_id, department_id
    from employee
    where primary_flag = 'Y'
    group by 1
)
select employee_id, department_id
from prim_emp
union
select employee_id, department_id
from exact_once
