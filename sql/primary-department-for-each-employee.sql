-- Approach 1: UNION
-- Retrieving employees that appear exactly once in the Employee
with exact_once as (
    select employee_id, department_id
    from employee
    group by 1
    having COUNT(employee_id) = 1
),
-- Retrieving employees with primary_flag set to 'Y'
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

