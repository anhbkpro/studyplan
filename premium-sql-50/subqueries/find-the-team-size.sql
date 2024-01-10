with size as
(
    select team_id, COUNT(*) as team_size
    from employee
    group by 1
)
select employee_id, team_size
from employee
left join size
using (team_id)
