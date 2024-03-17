with seniorcandidates as (
    select *,
           sum(salary) over (order by salary) as cumulative_salary
    from candidates
    where experience = 'senior'
),
juniorcandidates as (
    select *,
           sum(salary) over (order by salary) as cumulative_salary
    from candidates
    where experience = 'junior'
),
hiredseniors as (
    select count(*) as count
    from seniorcandidates
    where cumulative_salary <= 70000
),
remainingbudget as (
    select 70000 - coalesce((select cumulative_salary from seniorcandidates where cumulative_salary <= 70000 order by cumulative_salary desc limit 1), 0) as budget
),
hiredjuniors as (
    select count(*) as count
    from juniorcandidates, remainingbudget
    where juniorcandidates.cumulative_salary <= remainingbudget.budget
)
select 'senior' as experience, (select count from hiredseniors) as accepted_candidates
union
select 'junior' as experience, (select count from hiredjuniors) as accepted_candidates;
