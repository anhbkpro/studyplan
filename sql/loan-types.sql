with refinanced as (
    select distinct user_id
    from loans
    where loan_type = 'Refinance'
),
mortgage as (
    select distinct user_id
    from loans
    where loan_type = 'Mortgage'
)
select user_id from refinanced
where user_id in (select * from mortgage)
order by 1
