-- Approach 1: Using YEAR() to extract year from the date column and MAX() to find the latest record
select user_id, MAX(time_stamp) as last_stamp
from logins
where YEAR(time_stamp) = 2020
group by 1

-- Approach 2: Using EXTRACT() to get year from the date column and FIRST_VALUE() to find the latest record
select distinct user_id, FIRST_VALUE(time_stamp) over (partition by user_id order by time_stamp desc) as last_stamp
from logins
where EXTRACT(YEAR from time_stamp) = 2020
