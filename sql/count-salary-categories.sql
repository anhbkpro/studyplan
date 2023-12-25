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
UNION
select "Average Salary" as category, cnt as accounts_count
from average
UNION
select "High Salary" as category, cnt as accounts_count
from high
