select
  reports_to as employee_id,
  (
    select e2.name
    from employees e2
    where e1.reports_to = e2.employee_id
    limit 1
  ) as name,
  COUNT(employee_id) as reports_count,
  ROUND(AVG(age)) as average_age
from employees e1
where reports_to is not null
group by 1
order by 1

--- Solution 2: faster
select
    e1.employee_id,
    e1.name,
    COUNT(e2.employee_id) as reports_count,
    ROUND(AVG(e2.age)) as average_age
from employees e1
inner join employees e2
on e1.employee_id = e2.reports_to
group by e1.employee_id
order by e1.employee_id
