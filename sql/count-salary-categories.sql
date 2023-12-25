# Write your MySQL query statement below
with low as (
    select count(*) as cnt
    from accounts
    where income < 20000
),
average as (
    select count(*) as cnt
    from accounts
    where income <= 50000 and income >= 20000
),
high as (
    select count(*) as cnt
    from accounts
    where income > 50000
)
select "Low Salary" as category, cnt as accounts_count
from low
union
select "Average Salary" as category, cnt as accounts_count
from average
union
select "High Salary" as category, cnt as accounts_count
from high

--- Solution 2
select
    'Low Salary' as category,
    SUM(case when income < 20000 then 1 else 0 end) as accounts_count
from
    accounts

union
select
    'Average Salary' category,
    SUM(case when income >= 20000 AND income <= 50000 then 1 else 0 end)
    as accounts_count
from
    accounts

union
select
    'High Salary' category,
    SUM(case when income > 50000 then 1 else 0 end) as accounts_count
from
    accounts
