with add_rank as
(
  select id, company, salary,
    row_number() over(partition by company order by salary) as rnk
  from employee
),
add_count as
(
  select company, count(distinct id) as cnt
  from employee
  group by company
)
select a.id, a.company, a.salary
from add_rank a
join add_count b
on a.company = b.company
and a.rnk between b.cnt / 2 and b.cnt / 2 + 1
