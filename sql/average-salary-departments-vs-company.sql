with company_avg_salary_by_months as (
    select DATE_FORMAT(pay_date, '%Y-%m') as pay_month,
        ROUND(AVG(amount), 2) as company_salary_avg
    from salary
    group by 1
),

joined as (
    select *
    from salary
    left join employee using (employee_id)
    left join company_avg_salary_by_months on DATE_FORMAT(pay_date, '%Y-%m') = pay_month
)

select pay_month, department_id,
    CASE
        WHEN ROUND(AVG(amount), 2) > company_salary_avg then 'higher'
        WHEN ROUND(AVG(amount), 2) = company_salary_avg then 'same'
        ELSE 'lower'
    END as comparison
from joined
group by pay_month, department_id
