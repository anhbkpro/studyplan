with most_experienced as
(
    select project_id, employee_id,
        DENSE_RANK() OVER (PARTITION BY project_id ORDER BY experience_years desc) as rnk
    from project
    join employee
    using (employee_id)
)
select project_id, employee_id
from most_experienced m
where m.rnk = 1
