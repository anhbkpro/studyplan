with taxes as (
    select company_id,
    case
        when MAX(salary) < 1000 then 0
        when MAX(salary) <= 10000 and MAX(salary) >= 1000 then 24
        else 49
    end as tax_applied
    from salaries
    group by 1
)

select company_id, employee_id, employee_name,
    ROUND(salary - (tax_applied/100)*salary, 0) as salary
from salaries
join taxes
using (company_id)
