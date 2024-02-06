-- READMORE: https://mattboegner.com/improve-your-sql-skills-master-the-gaps-islands-problem/

with

temp0 as (
    select id,
        login_date,
        dense_rank() OVER(PARTITION BY id ORDER BY login_date) as row_num
    from logins
),

temp1 as (
    select
        id, login_date, row_num,
        DATE_ADD(login_date, INTERVAL -row_num DAY) as groupings
    from temp0
),

answer_table as (
    SELECT id,
        MIN(login_date) as startDate,
        MAX(login_date) as endDate,
        row_num,
        groupings,
        count(id),
        datediff(MAX(login_date), MIN(login_date)) as duration
    from temp1
    group by id, groupings
    having datediff(MAX(login_date), MIN(login_date)) >= 4
    order by id, startDate
)

select distinct a.id, name
from answer_table a
join accounts acc on acc.id = a.id
order by a.id
